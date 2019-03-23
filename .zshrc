# ====================== Exports  ========================

# Path to your oh-my-zsh installation.
export TERM="xterm-256color"
export ZSH=/Users/adam/.oh-my-zsh

# Fix for python and YCM - dont know whats going on atm
export DYLD_FORCE_FLAT_NAMESPACE=1
export PATH="/Users/adam/anaconda3/bin:$PATH"


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
alias npm-lint-node="npm install --save-dev eslint babel-eslint eslint-config-prettier eslint-plugin-import eslint-plugin-prettier prettier eslint-plugin-mocha"

# Shortcuts because I cbf installing lint tools all the time
alias lint="printf 'Hi Adam! These are the options you created for installing linting tools:\n- install_lint\n- install_lint--typescript\n- install_lint--react\n- install_lint--react--typescript\n'"

alias install_lint="yarn add --dev babel-eslint eslint-config-airbnb eslint-config-prettier eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-prettier prettier && cp ~/dotfiles/lintFiles/javascript_eslintrc.js .eslintrc.js && cp ~/dotfiles/lintFiles/prettierrc.js .prettierrc.js"
alias install_lint--typescript="yarn add --dev @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-config-airbnb eslint-config-prettier eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-prettier prettier && cp ~/dotfiles/lintFiles/typescript_eslintrc.js .eslintrc.js && cp ~/dotfiles/lintFiles/prettierrc.js .prettierrc.js"
alias install_lint--react="yarn add --dev eslint-config-airbnb eslint-config-prettier eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-prettier eslint-plugin-react prettier && cp ~/dotfiles/lintFiles/javascript_react_eslint.js .eslintrc.js && cp ~/dotfiles/lintFiles/prettierrc.js .prettierrc.js"
alias install_lint--react--typescript="yarn add --dev @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-config-airbnb eslint-config-prettier eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-prettier eslint-plugin-react prettier && cp ~/dotfiles/lintFiles/typescript_react_eslint.js .eslintrc.js && cp ~/dotfiles/lintFiles/prettierrc.js .prettierrc.js"

alias journal="cd ~/Projects/RapidoJournal"
alias startmon="cd ~/.mongodb && mongod --config ~/.mongodb/mongod.conf"

if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
	source /usr/local/share/chruby/chruby.sh
	source /usr/local/share/chruby/auto.sh
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Automatically call nvm use to load correct nvm settings when changing directory
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
local node_version="$(nvm version)"
local nvmrc_path="$(nvm_find_nvmrc)"

if [ -n "$nvmrc_path" ]; then
  local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

  if [ "$nvmrc_node_version" = "N/A" ]; then
    nvm install
  elif [ "$nvmrc_node_version" != "$node_version" ]; then
    nvm use
  fi
elif [ "$node_version" != "$(nvm version default)" ]; then
  echo "Reverting to nvm default version"
  nvm use default
fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/adam/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
