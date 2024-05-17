#! /usr/bin/env bash

YABAI_DIRECTION=$1

case $1 in
  "west")
    PANE_DIRECTION="left"
    DIRECTION_FLAG="-L"
    ;;
  "south")
    PANE_DIRECTION="bottom"
    DIRECTION_FLAG="-D"
    ;;
  "north")
    PANE_DIRECTION="top"
    DIRECTION_FLAG="-U"
    ;;
  "east")
    PANE_DIRECTION="right"
    DIRECTION_FLAG="-R"
    ;;
esac

if [[ $(tmux display-message -p "#{pane_at_${PANE_DIRECTION}}") == "0" ]] || [[ $OSTYPE == linux* ]]; then
  tmux select-pane ${DIRECTION_FLAG}
else
  yabai -m window --focus ${YABAI_DIRECTION} || yabai -m display --focus ${YABAI_DIRECTION} || true
fi
