#!/usr/bin/env zsh

echo " -----------------------------------------------------------"


###
# vim related
#
alias v="nvim --remote-silent "
alias upgrade_neovim="   source $VENV_HOME/neovim/bin/activate \
                      && pip install --upgrade pynvim pylama_pylint pylama urllib3 \
                      && deactivate \
                      && npm -g update neovim \
                      && gem update neovim \
                      && brew unlink neovim \
                      && brew reinstall neovim \
                      && source $VENV_HOME/local/bin/activate"
alias upgrade_submodules='(cd ~/.dotfiles && git submodule update --merge --remote)'
alias vim='nvim'
alias vi='nvim'
alias git_neo_log='git_log --first-parent $(nvim --version | grep commit | cut -d" " -f2)..'
export EDITOR='nvim'
export MANPAGER='nvim +Man!'
###

# useful shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias cdg='cd $(git rev-parse --show-toplevel)'

# cd into whatever is the forefront Finder window.
cdf() {  # short for cdfinder
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" || return
}

alias ld="ls --color=always -lhA | grep '^d'"
alias ll="ls --color=always -lhF"
alias lla="ls --color=always -lhFA"
alias ls="ls --color=always"

alias bin="cd ~/bin"
alias dev="cd ~/Dev"
alias grep="grep --color=always -i "

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias myip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print \$2}'"
alias show_routes="netstat -rn"

# dev
alias apache_start="sudo apachectl -k start"
alias apache_restart="sudo apachectl -k restart"
alias apache_stop="sudo apachectl -k stop"
alias apache_conf="cd /etc/apache2/"
alias apache_log="cd /var/log/apache2/"

# homebrew
alias update_brew="brew update && brew outdated"
alias upgrade_brew="brew upgrade && brew outdated"
alias brew_desc="brew desc"
alias brew_cask="brew cask"
alias brew_formulas_that_depend_on="brew uses --recursive "

eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_APP_PREFIX="$(dirname $(brew --prefix coreutils))"

# brew installed utils
export PATH="$HOMEBREW_APP_PREFIX/coreutils/libexec/gnubin:$HOMEBREW_APP_PREFIX/findutils/libexec/gnubin:$HOMEBREW_APP_PREFIX/grep/libexec/gnubin:$HOMEBREW_APP_PREFIX/gnu-sed/libexec/gnubin:$HOMEBREW_APP_PREFIX/gnu-tar/libexec/gnubin:$PATH"
export MANPATH="$HOMEBREW_APP_PREFIX/coreutils/libexec/gnuman:$MANPATH"

#
# Init Zinit plugin manager - https://github.com/zdharma-continuum/zinit
#
source $HOMEBREW_APP_PREFIX/zinit/zinit.zsh

zinit wait lucid for \
 blockf \
    zsh-users/zsh-completions

# Load a few important annexes, without Turbo
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Load starship theme (https://starship.rs/config/)
#zinit ice as"command" from"gh-r" \
#          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#          atpull"%atclone" src"init.zsh"
#zinit light starship/starship

# TODO: Use untill https://github.com/zdharma-continuum/zinit/issues/197 is fixed, then remove from brew
eval "$(starship init zsh)"


#
# VIM mode
#
zinit load softmoth/zsh-vim-mode


#
# Other
#

# TODO: customize autosuggestions
zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

#
# python
#

# Setup brewed python
export PATH="$HOMEBREW_APP_PREFIX/python/libexec/bin:$PATH"

alias upgrade_pip3="   pip3 install --upgrade setuptools wheel \
                    && pip3 install --upgrade pip        \
                    && for pkg in \$(pip3 list --outdated 2> /dev/null | tail -n +3 | awk '{ print \$1 }' | grep -v \"^pip3\\\$\"); do pip3 install -U \$pkg; done"
alias update_pip3="pip3 list --outdated"

# Setup virtual env
export VENV_HOME="$HOME/.venvs/"
source $VENV_HOME/local/bin/activate

# Setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# For installing dependencies
export LDFLAGS="$LDFLAGS -L$HOMEBREW_APP_PREFIX/libgeoip/lib/ -L$HOMEBREW_APP_PREFIX/openssl@1.1/lib -L$HOMEBREW_APP_PREFIX/libxml2/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/include/ -I$HOMEBREW_APP_PREFIX/openssl@1.1/include -I$HOMEBREW_APP_PREFIX/libxml2/include/libxml2/"
export PKG_CONFIG_PATH="$HOMEBREW_APP_PREFIX/libffi/lib/pkgconfig:$HOMEBREW_APP_PREFIX/openssl@1.1/lib/pkgconfig"
export PYCURL_SSL_LIBRARY=openssl
export PATH="$HOMEBREW_APP_PREFIX/openssl@1.1/bin:$PATH"


#
# git
#
alias git_bad_files='find . -name ".DS_Store" -or -name "Thumbs.db"'
alias git_log="git log --graph --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr)%Creset by %C(bold blue)%an%C(yellow)%d%Creset' --abbrev-commit --date=relative" # add --all to see all branches and not only the checkedout branch
alias git_log_all="git_log --branches --remotes --tags --decorate"
alias git_lastest_branches="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gp="git pull --rebase=merges"
alias gpush="git push --set-upstream origin HEAD" # Push current branch to origin with same branch name and set as tracking branch
alias gf="git fetch --all --prune && git fetch --tags --force && git fetch --tags --prune-tags"
alias gs="git status"
alias gde="git diff --ignore-space-at-eol -b -w --ignore-blank-lines"
alias gd="gde --no-ext-diff"
alias gdo="gd origin/\$(git rev-parse --abbrev-ref HEAD)..HEAD"

git-select-branch() {
  local BRANCH
  local exact
  local sort_opt="--no-sort"

  while getopts "es" opt; do
    case $opt in
      e) # exact match
        exact="--exact"
        ;;
      s) # sort results
        sort_opt=""
        ;;
      \?)
        return 1
        ;;
    esac
  done

  shift $((OPTIND - 1))

  # Interactively choose a branch to checkout
  BRANCH="$(git branch -a --color=always | fzf $exact $sort_opt --ansi -i | sed -e "s#^\s*remotes/[^/]*/##")"

  # Remove leading and trailing spaces
  BRANCH="$(echo -e "${BRANCH}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

  echo "$BRANCH"
}

gc() {
  local BRANCH
  BRANCH="$(git-select-branch "$@")"

  git checkout "$BRANCH"

  # Setup remote tracking if it isn't yet setup
  if [[ ! $(git rev-parse --symbolic-full-name --abbrev-ref "@{u}" 2> /dev/null) ]]; then
    git branch --set-upstream-to="origin/$BRANCH" "$BRANCH"
  fi
}

alias gc-='git checkout -'
alias gcd='git checkout develop'
alias gcs='git checkout staging'
alias gcm='git checkout master'
alias gcp='git cherry-pick --signoff -x'
alias git_commit_files="git diff-tree --no-commit-id --name-status -r"
alias t='git commit -m "tmp [no ci]"'

# gl - git commit browser (enter for show, ctrl-d for diff, ` toggles sort)
# TODO: Add options to seatch all branchs
gl() {
  local out shas sha q k git_user_name

  while getopts "me" opt; do
    case $opt in
      m) # Shortcut for "me". Only show your commits.
        git_user_name="$(git config --get user.name)"
        ;;
      e) # Searches for the exact wording.
        local exact="--exact"
        ;;
      \?)
        return 1
        ;;
    esac
  done

  shift $((OPTIND - 1))  # Shifts the positional parameters to exclude the flags

  while out=$(
      git log --graph \
              --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr)%Creset by %C(bold blue)%an%C(yellow)%d%Creset' \
              --abbrev-commit --date=relative --color=always --author="$git_user_name" "$@" |
      fzf $exact --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d --toggle-sort=\`
      ); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --no-ext-diff --color=always --ignore-space-at-eol -b -w --ignore-blank-lines "$shas" |
        diff-so-fancy |
        less --tabs=1,5 -R
    else
      for sha in $shas; do
        git show --color=always "$sha" | diff-so-fancy | less --tabs=1,5 -R
      done
    fi
  done
}
alias gl_exact='gl -e'
alias gl_author='gl -m'
alias glo='gl origin/$(git rev-parse --abbrev-ref HEAD)'
alias grh='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'


########
# node #
########
alias node_list='npm -g list --depth=0'
export PATH="$HOME/bin:/usr/local/share/npm/bin:$PATH"
alias update_project_node="npm outdated --quiet --depth=0"
alias update_node="update_project_node --global"
alias upgrade_project_node="npm update"
alias upgrade_node="nvm install node --latest-npm && ~/.dotfiles/setup-scripts/Nodefile && upgrade_project_node --global"

# nvm
export NVM_DIR="$HOME/.nvm"
# It loads every time I cd... need to fix that... export NVM_AUTOLOAD=1 # load a node version when if finds a .nvmrc file in the current working directory
# TODO: bring back, currently not working
[ -s "$HOMEBREW_APP_PREFIX/nvm/nvm.sh" ] && \. "$HOMEBREW_APP_PREFIX/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
#zinit depth'3' lucid light-mode for \
#  trigger-load'!yarn;npm;node' \
#    OMZP::nvm

####################
# RVM, Ruby, Rails #
####################
alias rc="rails console --sandbox"
alias gem_docs="yard server -g"
export PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH"
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/ruby/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/ruby/include"
eval "$(rbenv init - zsh)"

# Perl
# TODO: make fast! - eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

# cheat
export CHEATCOLORS=true # add colores to cheat

############
# win apps #
############
alias wine-heidisql="wine 'C:\Program Files\HeidiSQL\heidisql.exe' &"
alias wine-BC="wine start /UNIX ~/.wine/drive_c/Program\ Files/Beyond\ Compare\ 3/BCompare.exe &"
alias wine-ie8="wine 'C:\Program Files\Internet Explorer\iexplore' &"
alias wine-toad="WINEPREFIX='$HOME/.wine32' WINEARCH='win32' wine 'C:\\Program Files\Quest Software\Toad for MySQL Freeware 7.3\toad.exe'"
alias wine-npp="wine 'C:\Program Files\Notepad++\notepad++.exe' &"

####################
# Completion setup #
####################

# Needed, not sure why...
autoload -Uz compinit && compinit -C ~/.zcompdump
#
# source kubectl and terraform completion
# TODO: make fast! - source <(kubectl completion zsh)
# TODO: make fast! - which terraform-docs > /dev/null && source <(terraform-docs completion zsh)

#
# FZF
#
export FZF_COMPLETION_TRIGGER=',,'
export FZF_COMPLETION_OPTS='-m --ansi --border --info=inline'
export FZF_DEFAULT_COMMAND='fd --type f'
#RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
#export FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
#  fzf --bind "change:reload:$RG_PREFIX {q} || true" \
#      --ansi --disabled --query "$INITIAL_QUERY" \
#      --height=50% --layout=reverse

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Init fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# More ,, completions for: git, docker, gh, kubectl, make, npm, yarn
zinit load chitoku-k/fzf-zsh-completions

#
# Replace zsh's default completion selection menu with fzf!
#
zinit light Aloxaf/fzf-tab

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview  'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

#
# adds zsh completions (compsys) for ~10.7k commands
#
zinit ice lucid nocompile wait'0e' nocompletions
zinit load MenkeTechnologies/zsh-more-completions

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform


# Tips
# zi clist - list plugins

# zsh-z - autojump
# zhooks - tools to display all zsh hooks
export ZSHZ_CASE=smart
zinit depth'3' lucid for \
   trigger-load'!z' blockf \
      agkozak/zsh-z \
   trigger-load'!zhooks' \
      agkozak/zhooks \


###########
# History #
###########
zinit depth'3' lucid wait'0a' light-mode for \
  OMZL::history.zsh


#######
# OSX #
#######

# Open any file in MacOS Quicklook Preview
ql () { qlmanage -p "$*" >& /dev/null & }


#############
# Terraform #
#############
alias tf-reset="find ~ -type d -name ".terraform" -exec rm -rf {} +"
tfp() {
  terraform plan -parallelism=20 -out plan.out $* && terraform show plan.out | less -R
}
alias tfsummarize="tf-summarize -tree plan.out | less -R"
alias tfsummarize-json="tf-summarize -json plan.out | fx"
alias tfshow="terraform show plan.out | less -R"
alias tfshow-copy="terraform show -no-color plan.out | pbcopy"
alias tfv="terraform validate"
alias tfi="terraform init"
alias tfc="terraform console"

tf() {
  local plan_file="plan$$.out"

  local plan_params=""
  if [[ "$1" == "initial" ]]; then
    plan_params=""
  fi

  tfp $plan_params

  select action in "Show" "Summary" "Apply" "Exit" ; do
    case $action in
      Show ) echo show ;;
      Summary ) echo summary ;;
      Apply ) echo apply; break;;
      Exit ) echo -e "\nBye bye :)" break;;
      * ) echo -e "${RED}please answer${NC}"
    esac
  done

  rm -f $plan_file
}



####################
# general settings #
####################
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

function upgrade_say {
  echo -e "\n-----------\nUpgrade $1:\n-----------"
}

alias update_macos="mas outdated"
function upgrade_macos {
  if command -v xcodebuild > /dev/null; then
    XCODE_SAVE_VERSION="$(xcodebuild -version | grep --color=none Xcode)"
  fi

  mas upgrade

  if [[ "X$XCODE_SAVE_VERSION" != "X" && "$XCODE_SAVE_VERSION" != "$(xcodebuild -version | grep --color=none Xcode)" ]]; then
    sudo xcodebuild -license accept
  else
    echo "Xcode not upgraded"
  fi
  unset XCODE_SAVE_VERSION
}

alias update_all="update_node; update_pip3 && update_macos && update_brew && echo -e \"\$(date)\\n\""
#alias upgrade_all="   upgrade_say 'MAC'    && upgrade_macos     \
alias upgrade_all="   echo 'remove' \
                   && upgrade_say 'node'   && upgrade_node      \
                   && upgrade_say 'Brew'   && upgrade_brew      \
                   && upgrade_say 'pip3'   && upgrade_pip3      \
                   && source ~/.dotfiles/setup-scripts/Pipfile  \
                   && upgrade_say 'neovim' && upgrade_neovim    \
                   && upgrade_say 'Dotfiles (all submodules)' && upgrade_submodules \
                   && echo 'Done upgrading.'"
alias update_project="update_node_project && rake bower:list && bundle outdated"

[[ -f ~/.dotfiles/zshrc.private ]] && source ~/.dotfiles/zshrc.private

# setup brew command-not-found - commented out - too slow
#if brew command command-not-found-init > /dev/null 2>&1; then
#  eval "$(brew command-not-found-init)"
#fi

# Set ls colors (update from https://github.com/trapd00r/LS_COLORS)
# Another theme is: https://github.com/seebi/dircolors-solarized
#eval $(dircolors -b $HOME/.dotfiles/non-packaged-repos/LS_COLORS/LS_COLORS)
# Another option:
# http://linux-sxs.org/housekeeping/lscolors.html

# Marker - for command line bookmarks
# https://github.com/pindexis/marker - clone the repo when iTerm 2.9 is released
#[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"
echo " - Enable marker"
echo "Check: git-delta for git highlighting+"

##########################
# Other general settings #
##########################
# do not update brew every time brew command is used and don't autoupgrade on install
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_UPGRADE=1

export DISABLE_AUTO_TITLE=true # for tmux titles
alias tmux_attach="tmux -CC attach"

#[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

# PGP - allow it to work...
export GPG_TTY=$(tty)


####################
# Github shortcuts #
####################
alias gh-open="gh pr view --web"
alias gh-create="gh pr create"

#################
# AWS shortcuts #
#################
prompt_confirm() {
  local default_choice=${2}
  local prompt_options="y/n"

  if [[ "$default_choice" == "y" ]]; then
    prompt_options="Y/n"
  elif [[ "$default_choice" == "n" ]]; then
    prompt_options="y/N"
  fi

  local prompt_message="${1:-Continue?} [$prompt_options]: "

  while true; do
    echo -n "$prompt_message"
    read -r REPLY
    echo

    REPLY=${REPLY:-$default_choice}

    case $REPLY in
      [yY]) return 0 ;;
      [nN]) return 1 ;;
      *) printf " \033[31m %s \n\033[0m" "invalid input";;
    esac
  done
}


aws-ec2-terminate-instances() {
  declare -A selected_instances

  while true; do
    local selected_instance=$(aws-ec2-select-instance)
    local instance_id=$(echo "$selected_instance" | jq -r '.id')
    local instance_name=$(echo "$selected_instance" | jq -r '.name')

    if [[ -z "$instance_id" || -z "$instance_name" ]]; then
      if [ ${#selected_instances[@]} -eq 0 ]; then
        echo "No instances selected for termination."
        return 1
      fi
      break # Exit loop if no selection is made and proceed to confirmation
    fi

    selected_instances[${instance_name}]="$instance_id"

    yellow="\033[33m"
    cyan="\033[36m"
    green="\033[32m"
    reset="\033[0m"

    echo "${yellow}Selected instance:${reset} ${instance_id} (${cyan}${instance_name}${reset})" >&2

    if ! prompt_confirm "Do you want to select more instances?" "n"; then
        break
    fi
  done

  echo "You have selected the following instance(s) for termination:"
  # HERE: You might need to use a different sytax to iterate over
  #       the keys of the associative array (hashmap).
  # for name in "${!selected_instances[@]}"; do
  for name in "${(@k)selected_instances}"; do
    id="${selected_instances[$name]}"
    echo " ${yellow}-${reset} ${id} (${cyan}${name}${reset})"
  done

  if prompt_confirm "Are you sure you want to terminate the selected instance(s)?" "n"; then
    echo "${cyan}Terminating instances...${reset}"
    aws ec2 terminate-instances --instance-ids "${selected_instances[@]}"
    echo "${green}Instances terminated.${reset}"
  else
    echo "Operation aborted."
  fi
}

aws-ec2-select-instance() {
  local selected_instance=$(aws ec2 describe-instances --query "Reservations[].Instances[].[InstanceId,InstanceType,Tags[?Key==\`Name\`]|[0].Value,State.Name]" --output json | jq -r ".[]|@tsv" | grep --color=none 'running$' | fzf)

  local instance_id=$(echo "$selected_instance"  | cut -f1)
  local instance_name=$(echo "$selected_instance"  | cut -f3)

  # Use jq to safely create a JSON object
  jq -n --arg id "$instance_id" --arg name "$instance_name" \
    '{id: $id, name: $name}'
}

aws-ssh() {
  local save_profile="$AWS_PROFILE"
  if [[ "$1" != "" ]]; then
    export AWS_PROFILE="$1"
  fi

  local selected_instance=$(aws-ec2-select-instance)

  local instance_id=$(echo "$selected_instance" | jq -r '.id')
  local instance_name=$(echo "$selected_instance" | jq -r '.name')

  yellow="\033[33m"
  cyan="\033[36m"
  green="\033[32m"
  reset="\033[0m"

  echo "${yellow}Connected to:${reset} ${instance_id} (${cyan}${instance_name}${reset})" >&2

  aws ssm start-session --target "$instance_id"

  if [[ $save_profile != "" ]]; then
    export AWS_PROFILE="$save_profile"
  else
    unset AWS_PROFILE
  fi
}

aws-update-account-in-config() {
  cat <<-"EOD"
This function is used to add an entry to ~/.aws/config so you can later use 'aa' or 'aws-change-account'
Set the region for the account, note it is not the sso region, that should not be changed.

EOD

  aws configure sso

  echo
  echo "Now run 'aa' to change the profile to the account you need"
  echo
}

aws-select-eb-env() {
  # Ensure AWS CLI and fzf are installed
  command -v aws >/dev/null 2>&1 || { echo >&2 "AWS CLI is required but not installed.  Aborting."; return 1; }
  command -v fzf >/dev/null 2>&1 || { echo >&2 "fzf is required but not installed.  Aborting."; return 1; }

  environments=$(aws elasticbeanstalk describe-environments --no-include-deleted --query "Environments[*].[EnvironmentName]" --output text)

  # Select environment with fzf
  selected_env=$(echo "$environments" | fzf --prompt="Select Environment: ")

  # Exit if no environment is selected
  [ -z "$selected_env" ] && return
  yellow="\033[33m"
  reset="\033[0m"
  echo "${yellow}Selected Environment:${reset} $selected_env" >&2
  echo "$selected_env"
}

aws-change-account() {
  unset AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_ACCESS_KEY_ID
  if [[ "$1" != "" ]]; then
    profile="$1"
  else
    profile="$(aws configure list-profiles | grep --color=none superadmi | fzf)"
  fi

  export AWS_PROFILE="$profile"
}

aws-logout() {
  aws sso logout
  aws-exit-account
}

aws-exit-account() {
  unset AWS_PROFILE
  unset AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_ACCESS_KEY_ID
  chpwd
}

aws-elastic-beanstalk-health() {
  selected_env=$(aws-select-env)
  instances_health_info=$(aws elasticbeanstalk describe-instances-health --environment-name "$selected_env" --attribute-names All --output json)

  # Display beanstalk env health
  aws elasticbeanstalk describe-environment-health --environment-name "$selected_env" --attribute-names All --output table --no-paginate

  echo

  # Display platform and running version
  aws elasticbeanstalk describe-environments --environment-names "$selected_env" \
    --query 'Environments[*].{PlatformArn:PlatformArn, VersionLabel:VersionLabel}' --output text \
    | awk -F'\t' '{
      # Define ANSI color codes
      bold_light_blue="\033[1;94m";
      underline="\033[4m"
      reset="\033[0m";
      # Platform
      printf underline "Platform" reset ": ";
      split($1, platform, "/");
      for(i=2; i<=length(platform); i++) printf "%s%s", bold_light_blue platform[i] reset, (i==length(platform) ? "\n" : "/");
      # Running Version
      printf underline "Running Version" reset ": " bold_light_blue "%s" reset "\n", $2;
    }'

  # Define color codes
  reset_color="\033[0m"
  bold_white="\033[1m"
  instance_id_color="\033[94m"
  green_color="\033[32m"
  yellow_color="\033[33m"
  bold_yellow_color="\033[33;1m"  # Orange (bold yellow)
  red_color="\033[31m"
  cyan_color="\033[36m"
  underline="\033[4m"

  echo # Separate the environment health and the instances health
  headers="$(printf "%-20s %-9s %-10s %-16s %-27s %-50s\n" "Instance ID" "Status" "CPU Usage" "Uptime" "Causes")"
  echo -e "${bold_white}${headers}${reset_color}"

  # Display instances health
  echo "$instances_health_info" \
    | jq -r '.InstanceHealthList[] | [.InstanceId, .HealthStatus, (.System.CPUUtilization.Idle // 0), .LaunchedAt, (if (.Causes | length) > 0 then (.Causes | join(". ")) else "No specific causes" end)] | @tsv' \
    | while IFS=$'\t' read -r instance_id health_status idle launched_at causes; do
        now=$(date +%s)
        launched_at_sec=$(date -d "$launched_at" +%s)
        elapsed=$((now - launched_at_sec))
        uptime=$(printf '%dd %dh %dm %ds' $((elapsed/86400)) $((elapsed%86400/3600)) $((elapsed%3600/60)) $((elapsed%60)))

        # Apply bold yellow if uptime is more than a week
        if [ $elapsed -ge 604800 ]; then
          uptime_color="$bold_yellow_color"
        else
          uptime_color="$reset_color"
        fi

        cpu_usage=$(echo "scale=2; 100 - $idle" | bc)  # Calculate CPU usage once

        # Dynamic coloring for CPU usage based on percentage
        if (( $(echo "$cpu_usage < 50" | bc) )); then
          cpu_color="$green_color"
        elif (( $(echo "$cpu_usage >= 50 && $cpu_usage < 70" | bc) )); then
          cpu_color="$yellow_color"
        elif (( $(echo "$cpu_usage >= 70 && $cpu_usage < 90" | bc) )); then
          cpu_color="$bold_yellow_color"
        else
          cpu_color="$red_color"
        fi

        # Status coloring
        case $health_status in
          "Ok") status_color="$green_color" ;;
          "Warning") status_color="$yellow_color" ;;
          "Info") status_color="$cyan_color" ;;
          "Degraded"|"Severe") status_color="$red_color" ;;
          *) status_color="$reset_color" ;;
        esac

        effective_causes="$(echo -e "${underline}${causes}${reset_color}")"

        # Adjust printf statement for optimal column width
        printf "%b%-20s%b %b%-9s%b %b%-10s%b %b%-16s%b %-50s\n" \
          "$instance_id_color" "$instance_id" "$reset_color" \
          "$status_color" "$health_status" "$reset_color" \
          "$cpu_color" "$(printf '%.2f%%' $cpu_usage)" "$reset_color" \
          "$uptime_color" "$uptime" "$reset_color" \
          "$effective_causes"
      done
}

aws-elastic-beanstalk-platform() {
  selected_env=$(aws-select-eb-env)
  aws elasticbeanstalk describe-environments --environment-names "$selected_env" \
    --query 'Environments[*].{PlatformArn:PlatformArn, VersionLabel:VersionLabel}' --output text | \
    awk -F'\t' '{
      # Define ANSI color codes
      green="\033[32m";
      cyan="\033[36m";
      reset="\033[0m";

      # Platform
      printf green "Platform: " reset;
      split($1, platform, "/");
      for(i=2; i<=length(platform); i++) printf "%s%s", platform[i], (i==length(platform) ? "\n" : "/");

      # Running Version
      printf cyan "Running Version: " reset "%s\n", $2;
    }'
}

aws-elastic-beanstalk-events() {
  # Ensure AWS CLI and fzf are installed
  command -v aws >/dev/null 2>&1 || { echo >&2 "AWS CLI is required but not installed.  Aborting."; return 1; }
  command -v fzf >/dev/null 2>&1 || { echo >&2 "fzf is required but not installed.  Aborting."; return 1; }
  command -v gawk >/dev/null 2>&1 || { echo >&2 "gawk is required but not installed.  Aborting."; return 1; }

  max_items=${1:-100} # Use the first argument or a default value

  # Fetch Elastic Beanstalk environments
  environments=$(aws elasticbeanstalk describe-environments --no-include-deleted --query "Environments[*].[EnvironmentName]" --output text)

  # Select environment with fzf
  selected_env=$(echo "$environments" | fzf --prompt="Select Environment: ")

  # Exit if no environment is selected
  [ -z "$selected_env" ] && return

  echo "Selected environment: $selected_env"

  PS3="Choose an option (numeric): "
  select opt in "Events" "Health"; do
    if [[ $opt == "Events" ]]; then
      # Fetch events with severity and format into a table with headers and borders
      events=$(aws elasticbeanstalk describe-events --environment-name "$selected_env" --max-items=$max_items --query "Events[*].[EventDate,Severity,Message]" --output text)
      {
        echo "$events"
      } | gawk -v RED="\033[0;31m" -v YELLOW="\033[0;33m" -v CYAN="\033[0;36m" -v NOCOLOR="\033[0m" '
      BEGIN {
        printf "%-35s %-11s %-s\n", "Date", "Severity", "Message";
        printf "%-35s %-11s %-s\n", "----", "--------", "-------";
      }
      {
        if (NR > 2) {
          # Split date and time, then handle timezone
          split($1, a, "T");
          split(a[2], b, "[+-]", seps);
          time_part = substr(b[1], 1, 8);

          # Append the timezone sign and the offset
          timezone = seps[1] b[2];
          date = a[1] " " time_part " " timezone;

          severity = $2;
          color = "";
          if (severity ~ /ERROR/) color = RED;
          else if (severity ~ /WARN/) color = YELLOW;
          else if (severity ~ /INFO/) color = CYAN;

          $2 = color severity NOCOLOR;
          message = "";
          for(i = 3; i <= NF; i++) {
              message = message $i " ";
          }
          printf "%-35s %-22s %-s\n", date, $2, message;
        }
      }' | less -R -S
      break
    elif [[ $opt == "Health" ]]; then
      # Fetch health and format into a table with headers and borders
      aws elasticbeanstalk describe-environment-health --environment-name "$selected_env" --attribute-names All --output table
      break
    else
      echo "Invalid option. Please try again."
    fi
  done
}

alias aws-whoami='aws sts get-caller-identity'
alias ati="aws-ec2-terminate-instances"
alias aa="aws-change-account"
alias ac="aws-console"
alias as="aws-ssh"
alias eb_events="aws-elastic-beanstalk-events"

# Set the iTerm2 title
function title {
  echo -ne "\033]0;"$*"\007"
}

# Function to run on directory change
function chpwd {
  local git_path="$(pwd)"
  git_path="${git_path#"$HOME/work/"}"
  git_path="$(echo $git_path | cut -d/ -f1)"

  local aws_title=""
  if [[ -n $AWS_PROFILE ]]; then
     aws_title="AWS account: $(echo "$AWS_PROFILE" | cut -d- -f1-3)"
  fi

  local git_title=""
  if [[ "$git_path" != "" ]]; then
    git_title="Git repo: $git_path"
  fi

  local title
  if [[ -n $git_title ]]; then
    title="$git_title"
    if [[ -n $aws_title ]]; then
       title="$title ~ $aws_title"
    fi
  elif [[ -n $aws_title ]]; then
    title="$aws_title"
  else
    title="Default"
  fi

  title "$title"
}
chpwd

#
# Maccy
alias maccy-disable="defaults write org.p0deje.Maccy ignoreEvents true"
alias maccy-enable="defaults write org.p0deje.Maccy ignoreEvents false"

export PATH=".:$PATH:/usr/local/bin/"

echo " -----------------------------------------------------------"
