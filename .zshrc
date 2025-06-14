# ====================== Exports  ========================

# Path to your oh-my-zsh installation.
export TERM="xterm-256color"
export ZSH=/Users/adam/.oh-my-zsh

# Fix for python and YCM - dont know whats going on atm
export DYLD_FORCE_FLAT_NAMESPACE=1
# export PATH="/Users/adam/anaconda3/bin:$PATH"  # commented out by conda initialize


# ====================== General Settings ========================

# Set name of the theme to load.
ZSH_THEME="avit"

# Display dots while waiting for completion
 COMPLETION_WAITING_DOTS="true"


# ====================== Plugin Settings ========================

# Plugins
plugins=(git rails zeus zsh-syntax-highlighting zsh-autosuggestions ssh-agent)

# ====================== Alias Settings ========================

#alias lvh="zeus s -p 3000 -b lvh.me"
alias gs="git status"
alias cdf="cd ~/projects/foodi/"
alias cda="cd ~/projects/ajay/"
#alias foreman="bundle exec foreman start"
alias apps="cd ~/Dropbox/Uni/ApplicationsProgramming/"
alias fundies="cd ~/Dropbox/Uni/FundamentalsOfCProgramming/"
alias deep="cd ~/Dropbox/Uni/DeepNeuralNetworksAndAI/"
alias jup="jupyter notebook"
alias py="python"
#alias vi="mvim -v"
# alias v="/usr/local/bin/vim"
alias vim="nvim"
alias py35="source activate py35"
alias npm-lint-node="npm install --save-dev eslint babel-eslint eslint-config-prettier eslint-plugin-import eslint-plugin-prettier prettier eslint-plugin-mocha"

# Shortcuts because I cbf installing lint tools all the time
alias lint="printf 'Hi Adam! These are the options you created for installing linting tools:\n- install_lint\n- install_lint--typescript\n- install_lint--react\n- install_lint--react--typescript\n'"

alias install_lint="yarn add --dev babel-eslint eslint-config-airbnb eslint-config-prettier eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-prettier prettier && cp ~/dotfiles/lintFiles/javascript_eslintrc.js .eslintrc.js && cp ~/dotfiles/lintFiles/prettierrc.js .prettierrc.js"
alias install_lint--typescript="yarn add --dev @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-config-airbnb eslint-config-prettier eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-prettier prettier && cp ~/dotfiles/lintFiles/typescript_eslintrc.js .eslintrc.js && cp ~/dotfiles/lintFiles/prettierrc.js .prettierrc.js"
alias install_lint--react="yarn add --dev eslint-config-airbnb eslint-config-prettier eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-prettier eslint-plugin-react prettier && cp ~/dotfiles/lintFiles/javascript_react_eslint.js .eslintrc.js && cp ~/dotfiles/lintFiles/prettierrc.js .prettierrc.js"
alias install_lint--react--typescript="yarn add --dev @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-config-airbnb eslint-config-prettier eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-prettier eslint-plugin-react prettier && cp ~/dotfiles/lintFiles/typescript_react_eslint.js .eslintrc.js && cp ~/dotfiles/lintFiles/prettierrc.js .prettierrc.js"

alias journal="cd ~/Projects/FoodBomb/Journal"

# Foodbomb Repos
alias fb="cd ~/Projects/FoodBomb/App"
alias yehnah="cd ~/Projects/yeh-nah"
alias backend="cd ~/Projects/FoodBomb/App/backend-phplayer/php"
alias ui="cd ~/Projects/FoodBomb/App/bit-ui-library/app"
alias ui2="cd /Users/adam/Projects/FoodBomb/App/bit-ui-library-v2"
alias uistore="cd ~/Projects/FoodBomb/App/firebase/functions"
alias shop="cd ~/Projects/FoodBomb/App/frontend-shop/app"
alias reports="cd ~/Projects/FoodBomb/App/reports-service"
alias delivery-run="cd ~/Projects/FoodBomb/App/delivery-run-tracker/"
alias venue="cd ~/Projects/FoodBomb/App/frontend-shop/app"
alias supplier="cd ~/Projects/FoodBomb/App/supplier-portal/app"
alias delivery="cd ~/Projects/FoodBomb/App/delivery-preferences"
alias delivery-api="cd ~/Projects/FoodBomb/App/delivery-preferences-api"
alias delivery-api-bash="cd ~/Projects/FoodBomb/App/delivery-preferences-api && docker-compose exec api entrypoint.sh bash"
alias delivery-api-test="cd ~/Projects/FoodBomb/App/delivery-preferences-api && docker-compose exec api pipenv run pytest --verbose -s"
alias delivery-api-watch="cd ~/Projects/FoodBomb/App/delivery-preferences-api && docker-compose exec api pipenv run ptw --verbose --runner 'pytest -s -vv --color=yes'"
alias staff="cd ~/Projects/FoodBomb/App/staff-portal/app"
alias supplier-api="cd ~/Projects/Foodbomb/App/supplier-api/"
alias venue-api="cd ~/Projects/FoodBomb/App/venue-api"
alias manageCompleteOrders="curl -X POST -H 'Content-type: application/json' -H 'Authorization: FAKE_INTERNAL_API_KEY' http://localhost:9000/cronJobDispatcher.php\?function\=manageCompleteOrders"
alias sendInvoices="curl -X POST -H 'Content-type: application/json' -H 'Authorization: FAKE_INTERNAL_API_KEY' http://localhost:9000/cronJobDispatcher.php\?function\=sendInvoices"
alias sendOrderEmails="curl -X POST -H 'Content-type: application/json' -H 'Authorization: FAKE_INTERNAL_API_KEY' http://localhost:9000/api/internal/jobs/send-new-order-email-to-venue && curl -X POST -H 'Content-type: application/json' -H 'Authorization: FAKE_INTERNAL_API_KEY' http://localhost:9000/api/internal/jobs/send-new-order-email-to-supplier"

alias reporting="cd ~/Projects/FoodBomb/App/frontend-reporting/reporting"
alias infra="cd ~/Projects/FoodBomb/App/backend-infrastructure"
alias mumv-infra="cd ~/Projects/FoodBomb/App/mumv-infra"
alias backend-lib="cd ~/Projects/FoodBomb/App/foodbomb-backend-lib"
alias orders="cd ~/Projects/FoodBomb/App/backend-orders"
alias opencart="cd ~/Projects/FoodBomb/App/sh-foodbomb-dev"
alias products="cd ~/Projects/FoodBomb/App/backend-products/app"
alias pauls="ECHO 'ITS CALLED STAFF, YOU MORON!'"

alias duck="cd ~/Projects/theDuck"
alias supplier-duck="cd ~/Projects/supplier-duck"
alias venue-duck="cd ~/Projects/venue-duck"
alias sequel="cd ~/Projects/sequel/nextPrototype/sequel-marketing"
alias ssh-sequel='cd /Users/adam/Documents/ScalarLabs/Clients/Sequel && ssh -i "ec2-strapi-key-pair-2.pem" ubuntu@ec2-54-215-96-5.us-west-1.compute.amazonaws.com'
alias sequel-cms="cd ~/Projects/sequel/sequel-cms"
alias sequel-cms-site="Open https://cms.trysequel.com/admin/"
alias scalar="cd ~/Projects/ScalarPlaceholder"
alias dadalearn="cd ~/Projects/DadaLearn/dadalearn"
alias sortd="cd ~/Projects/sortd"
alias customer="cd ~/Projects/sortd/svc-customer"
alias parser="cd ~/Projects/sortd/svc-html-parser"
alias mobile="cd ~/Projects/sortd/mobile-app"
alias extension="cd ~/Projects/sortd/chrome-extension"
alias extension-login="cd ~/Projects/sortd/ai-extension-login-shortcut"
alias admin="cd ~/Projects/sortd/admin-portal/"
alias web="cd ~/Projects/sortd/webapp-2.0"

alias browser-tools="npx @agentdeskai/browser-tools-server@1.2.0"

alias instabug-sourcemap="npx react-native bundle --platform ios \
        --entry-file index.js \
        --dev false \
        --bundle-output ./ios/main.jsbundle \
        --sourcemap-output ./ios-sourcemap.json && 
        zip ./ios-sourcemap.zip ./ios-sourcemap.json"
alias ngrok-sortd="ngrok http --domain=bug-sure-moray.ngrok-free.app 8000"
alias ngrok-sequel="ngrok http --domain=bug-sure-moray.ngrok-free.app 3000"
alias sploot="cd ~/Projects/sploot"

alias codacy="codacy-analysis-cli analyze --verbose"

alias phpcontainer="docker-compose exec php bash"
alias phptest="docker-compose exec php bash ./vendor/bin/phpunit --testdox tests"
# alias phptest="docker exec -ti backend-phplayer_php_1 sh ./vendor/bin/phpunit --testdox tests"
alias phpfix="docker-compose exec php bash ./cs-script.sh"
# alias phpfix="docker exec -ti backend-phplayer_php_1 sh ./cs-script.sh"

alias master="git ch master"

alias dcu="docker-compose up"
alias dcufast="DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 BUILDKIT_PROGRESS=plain docker-compose up"
alias dcd="docker-compose down"

alias startmon="cd ~/.mongodb && mongod --config ~/.mongodb/mongod.conf"
alias alex="ssh -i ~/.ssh/spam_key foodbomb2@foodbomb2s-MacBook-Pro.local"
alias cam="ssh -i ~/.ssh/spam_key cameronmercer1@192.168.10.107"

# thefuck
eval $(thefuck --alias)

# if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
# 	source /usr/local/share/chruby/chruby.sh
# 	source /usr/local/share/chruby/auto.sh
# fi

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

# Must be before sourcing oh-my-zsh.sh.
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/adam/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/adam/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/adam/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/adam/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/adam/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

export PATH=/usr/local/bin:$PATH

# firewall is blocking mosh
alias firepower='sudo /usr/libexec/ApplicationFirewall/socketfilterfw'
fix_mosh_server() {
  # temporarily shut firewall off
  firepower --setglobalstate off

  # add symlinked location to firewall
  firepower --add $(which mosh-server)
  firepower --unblockapp $(which mosh-server)

  # add homebrew location to firewall
  firepower --add $(brew --prefix)/Cellar/mosh/1.3.2_18/bin/mosh-server
  firepower --unblockapp $(brew --prefix)/Cellar/mosh/1.3.2_18/bin/mosh-server

  # re-enable firewall
  firepower --setglobalstate on
}

# Created by `pipx` on 2022-03-04 02:58:30
export PATH="$PATH:/Users/adam/.local/bin"

# Created by `pipx` on 2022-03-04 02:58:33
export PATH="$PATH:/Users/adam/Library/Python/3.9/bin"

# bit
export PATH="$PATH:/Users/adam/bin"
# bit end

# Postgres (Sploot)
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

eval "$(rbenv init - zsh)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

if [ -n "$TMUX" ]; then
  export ITERM_SESSION_ID=$(tmux show-environment ITERM_SESSION_ID 2>/dev/null || echo "iTermNotSet")
  export TERM_PROGRAM=${TERM_PROGRAM:-iTerm.app}
fi

# Added by Windsurf
export PATH="/Users/adam/.codeium/windsurf/bin:$PATH"

alias dev="tmux attach -t dev || tmux new -s dev"
