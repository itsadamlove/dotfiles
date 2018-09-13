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
#alias vi="mvim -v"
alias py35="source activate py35"
alias npm-lint-react="npm install --save-dev eslint babel-eslint eslint-config-prettier eslint-plugin-import eslint-plugin-prettier eslint-plugin-react prettier"
alias npm-lint-node="npm install --save-dev eslint babel-eslint eslint-config-prettier eslint-plugin-import eslint-plugin-prettier prettier eslint-plugin-mocha"

if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
	source /usr/local/share/chruby/chruby.sh
	source /usr/local/share/chruby/auto.sh
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Automatically call nvm use to load correct nvm settings when changing directory
# place this after nvm initialization!
#autoload -U add-zsh-hook
#load-nvmrc() {
#local node_version="$(nvm version)"
#local nvmrc_path="$(nvm_find_nvmrc)"

#if [ -n "$nvmrc_path" ]; then
  #local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

  #if [ "$nvmrc_node_version" = "N/A" ]; then
    #nvm install
  #elif [ "$nvmrc_node_version" != "$node_version" ]; then
    #nvm use
  #fi
#elif [ "$node_version" != "$(nvm version default)" ]; then
  #echo "Reverting to nvm default version"
  #nvm use default
#fi
#}
#add-zsh-hook chpwd load-nvmrc
#load-nvmrc

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
