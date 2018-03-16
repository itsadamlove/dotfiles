# ====================== Exports  ========================

# Path to your oh-my-zsh installation.
export TERM="xterm-256color"
export ZSH=/Users/adamlove/.oh-my-zsh


# ====================== General Settings ========================

# Set name of the theme to load.
ZSH_THEME="avit"

# Display dots while waiting for completion
 COMPLETION_WAITING_DOTS="true"


# ====================== Plugin Settings ========================

# Plugins
plugins=(git rails zeus zsh-syntax-highlighting zsh-autosuggestions)

# ====================== Alias Settings ========================

#alias lvh="zeus s -p 3000 -b lvh.me"
alias cdf="cd ~/projects/foodi/"
alias cda="cd ~/projects/ajay/"
#alias foreman="bundle exec foreman start"
alias apps="cd ~/Dropbox/Uni/ApplicationsProgramming/"
alias fundies="cd ~/Dropbox/Uni/FundamentalsOfCProgramming/"
alias deep="cd ~/Dropbox/Uni/DeepNeuralNetworksAndAI/"
alias jup="jupyter notebook"
alias py="python"
alias vi="mvim -v"
alias py35="source activate py35"

if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
	source /usr/local/share/chruby/chruby.sh
	source /usr/local/share/chruby/auto.sh
fi

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
