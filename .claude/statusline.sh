#!/bin/bash

# Read JSON input from stdin
input=$(cat)

if ! command -v jq &> /dev/null; then
    printf "\e[1;34m%s\e[0m\n" "$(basename "$(pwd)")"
    exit 0
fi

# --- Extract fields from JSON ---
model_name=$(echo "$input" | jq -r '.model.display_name // "Claude"' 2>/dev/null || echo "Claude")
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // ""' 2>/dev/null || pwd)
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty' 2>/dev/null)
total_cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty' 2>/dev/null)
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty' 2>/dev/null)
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // empty' 2>/dev/null)
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // empty' 2>/dev/null)
rate_used_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty' 2>/dev/null)
rate_resets_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty' 2>/dev/null)

# --- Build shortened path: last 3 segments, replacing $HOME with ~ ---
short_dir=$(echo "$current_dir" | sed "s|^$HOME|~|")
short_dir=$(echo "$short_dir" | awk -F'/' '{
    n = NF
    if (n <= 3) { print $0 }
    else { print $(n-2) "/" $(n-1) "/" $n }
}')

# --- Git branch + dirty state (cached with 5s TTL) ---
git_branch=""
git_dirty=""
if GIT_OPTIONAL_LOCKS=0 git -c gc.auto=0 rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git_branch=$(GIT_OPTIONAL_LOCKS=0 git -c gc.auto=0 branch --show-current 2>/dev/null || echo "detached")

    # Cache git status to a temp file with 5-second TTL
    git_root=$(GIT_OPTIONAL_LOCKS=0 git -c gc.auto=0 rev-parse --show-toplevel 2>/dev/null)
    cache_file="/tmp/statusline_gitstatus_$(echo "$git_root" | md5sum 2>/dev/null | cut -c1-8 || echo "default")"
    now=$(date +%s)
    cache_valid=0
    if [[ -f "$cache_file" ]]; then
        cache_mtime=$(stat -f %m "$cache_file" 2>/dev/null || stat -c %Y "$cache_file" 2>/dev/null || echo 0)
        if (( now - cache_mtime < 5 )); then
            cache_valid=1
        fi
    fi
    if [[ $cache_valid -eq 1 ]]; then
        changed_count=$(cat "$cache_file")
    else
        changed_count=$(GIT_OPTIONAL_LOCKS=0 git -c gc.auto=0 status --porcelain 2>/dev/null | wc -l | tr -d ' ')
        echo "$changed_count" > "$cache_file"
    fi

    if [[ -n "$changed_count" && "$changed_count" -gt 0 ]]; then
        git_dirty="*${changed_count}"
    fi
fi

# --- Duration: convert ms to human-readable ---
format_duration() {
    local ms=$1
    if [[ -z "$ms" || "$ms" == "null" ]]; then echo ""; return; fi
    local total_s=$(( ms / 1000 ))
    local h=$(( total_s / 3600 ))
    local m=$(( (total_s % 3600) / 60 ))
    local s=$(( total_s % 60 ))
    if (( h > 0 )); then
        echo "${h}h ${m}m"
    elif (( m > 0 )); then
        echo "${m}m"
    else
        echo "${s}s"
    fi
}

# --- Rate limit countdown ---
format_countdown() {
    local resets_at=$1
    if [[ -z "$resets_at" || "$resets_at" == "null" ]]; then echo ""; return; fi
    local now=$(date +%s)
    local diff=$(( resets_at - now ))
    if (( diff <= 0 )); then echo ""; return; fi
    local h=$(( diff / 3600 ))
    local m=$(( (diff % 3600) / 60 ))
    if (( h > 0 )); then
        echo "${h}h ${m}m"
    else
        echo "${m}m"
    fi
}

duration_str=$(format_duration "$duration_ms")
rate_countdown=$(format_countdown "$rate_resets_at")

# ============================================================
# LINE 1: path | git branch (dirty) | model name
# ============================================================

# Path — bold blue
printf "\e[1;34m%s\e[0m" "$short_dir"

# Git branch — green, dirty indicator in yellow
if [[ -n "$git_branch" ]]; then
    printf " \e[32m%s\e[0m" "$git_branch"
    if [[ -n "$git_dirty" ]]; then
        printf "\e[33m%s\e[0m" "$git_dirty"
    fi
fi

# Model name — cyan
printf " \e[36m%s\e[0m" "$model_name"

printf "\n"

# ============================================================
# LINE 2: cost | ctx% | rate% | lines +/- | duration
# ============================================================

line2_parts=()

# Cost — green < $0.50, yellow < $2, red >= $2
if [[ -n "$total_cost" && "$total_cost" != "null" ]]; then
    cost_fmt=$(printf "%.2f" "$total_cost" 2>/dev/null || echo "0.00")
    # Use awk for float comparison
    cost_color=$(awk -v c="$total_cost" 'BEGIN {
        if (c+0 < 0.50) print "32"
        else if (c+0 < 2.00) print "33"
        else print "31"
    }')
    line2_parts+=("$(printf "\e[%sm\$%s\e[0m" "$cost_color" "$cost_fmt")")
fi

# Context usage — green < 50%, yellow < 80%, red >= 80%
if [[ -n "$used_pct" && "$used_pct" != "null" ]]; then
    used_int=${used_pct%.*}
    used_int=${used_int:-0}
    if (( used_int < 50 )); then
        line2_parts+=("$(printf "\e[32mctx %s%%\e[0m" "$used_int")")
    elif (( used_int < 80 )); then
        line2_parts+=("$(printf "\e[33mctx %s%%\e[0m" "$used_int")")
    else
        line2_parts+=("$(printf "\e[31mctx %s%%\e[0m" "$used_int")")
    fi
fi

# Rate limit — only show if data is present
if [[ -n "$rate_used_pct" && "$rate_used_pct" != "null" ]]; then
    rate_int=${rate_used_pct%.*}
    rate_int=${rate_int:-0}
    if (( rate_int < 50 )); then
        rate_color=32
    elif (( rate_int < 80 )); then
        rate_color=33
    else
        rate_color=31
    fi
    if [[ -n "$rate_countdown" ]]; then
        line2_parts+=("$(printf "\e[%smrate %s%% (%s)\e[0m" "$rate_color" "$rate_int" "$rate_countdown")")
    else
        line2_parts+=("$(printf "\e[%smrate %s%%\e[0m" "$rate_color" "$rate_int")")
    fi
fi

# Lines added/removed — skip if both zero or missing
added_int=${lines_added:-0}
removed_int=${lines_removed:-0}
if (( added_int > 0 || removed_int > 0 )); then
    line2_parts+=("$(printf "\e[32m+%s\e[0m \e[31m-%s\e[0m" "$added_int" "$removed_int")")
fi

# Duration — dim/grey
if [[ -n "$duration_str" ]]; then
    line2_parts+=("$(printf "\e[2m%s\e[0m" "$duration_str")")
fi

# Join with spaces and print
if (( ${#line2_parts[@]} > 0 )); then
    first=1
    for part in "${line2_parts[@]}"; do
        if (( first )); then
            printf "%s" "$part"
            first=0
        else
            printf " %s" "$part"
        fi
    done
    printf "\n"
fi