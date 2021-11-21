#!/usr/bin/env zsh

echo " -----------------------------------------------------------"

# Init Zinit plugin manager - https://zdharma.github.io/zinit/wiki/INTRODUCTION/
source /usr/local/opt/zinit/zinit.zsh

zinit wait lucid for \
 blockf \
    zsh-users/zsh-completions

# Load starship theme (https://starship.rs/config/)
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

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

###
# vim related
#
alias v="mvim --remote-silent "
alias upgrade_neovim="   workon neovim3 \
                      && pip install --upgrade pynvim pylama_pylint pylama \
                      && deactivate \
                      && npm -g update neovim \
                      && brew unlink neovim \
                      && brew install --HEAD neovim"
alias upgrade_submodules='(cd ~/.dotfiles && git submodule update --merge --remote)'
alias vim='nvim'
alias vi='nvim'
alias git_neo_log='git_log --first-parent $(nvim --version | grep commit | cut -d" " -f2)..'
export EDITOR='nvim'
export MANPAGER="nvim -c 'set ft=man' -"
###

# useful shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."

# cd into whatever is the forefront Finder window.
cdf() {  # short for cdfinder
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" || return
}

alias ld="exa --color=always -lhA | grep '^d'"
alias ll="exa --color=always -lhF"
alias lla="exa --color=always -lhFA"
alias ls="exa --color=always"

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
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
 
# brew installed utils
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"

#
# python
#
export PATH="/usr/local/opt/python/libexec/bin:$HOME/Library/Python/3.9/bin:$PATH"

alias upgrade_pip3="   pip3 install --upgrade setuptools wheel \
                    && pip3 install --upgrade pip        \
                    && pip3 install --upgrade virtualenv virtualenvwrapper \
                    && for pkg in \$(pip3 list --outdated 2> /dev/null | tail -n +3 | awk '{ print \$1 }' | grep -v \"^pip3\\\$\"); do pip3 install -U \$pkg; done"
alias update_pip3="pip3 list --outdated"

# Setup virtual env
export WORKON_HOME=~/work/virtualenvs
zinit depth'3' lucid wait'0a' light-mode for \
  OMZP::virtualenvwrapper

# For installing dependencies
export LDFLAGS="$LDFLAGS -L/usr/local/opt/libgeoip/lib/ -L/usr/local/opt/openssl/lib -L/usr/local/opt/libxml2/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/include/ -I/usr/local/opt/openssl/include -I/usr/local/opt/libxml2/include/libxml2/"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
export PYCURL_SSL_LIBRARY=openssl


#
# git
#
alias git_bad_files='find . -name ".DS_Store" -or -name "Thumbs.db"'
alias git_log="git log --graph --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr)%Creset by %C(bold blue)%an%C(yellow)%d%Creset' --abbrev-commit --date=relative" # add --all to see all branches and not only the checkedout branch
alias git_log_all="git_log --branches --remotes --tags --decorate"
alias git_lastest_branches="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gp="git pull --rebase=merges"
alias gpush="git push --set-upstream origin HEAD" # Push current branch to origin with same branch name and set as tracking branch
alias gf="git fetch --all && git fetch --tags --force"
alias gs="git status"
alias gde="git diff --ignore-space-at-eol -b -w --ignore-blank-lines"
alias gd="gde --no-ext-diff"
alias gdo="gd origin/\$(git rev-parse --abbrev-ref HEAD)..HEAD"
gc() {
  local BRANCH
  # Interactivly choose a branch to checkout
  BRANCH="$(git branch -a | fzf --ansi | sed -e "s#^\s*remotes/[^/]*/##")"
  # Remove leading and trailing spaces
  BRANCH="$(echo -e "${BRANCH}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

  git checkout "$BRANCH"

  # Setup remote tracking if it isn't yet setup
  if [[ ! $(git rev-parse --symbolic-full-name --abbrev-ref "@{u}" 2> /dev/null) ]]; then
    git branch --set-upstream-to="origin/$BRANCH" "$BRANCH"
  fi
}

alias gc-='git checkout -'
alias gcd='git checkout develop'
alias gcm='git checkout master'
alias gcp='git cherry-pick --signoff -x'
alias git_commit_files="git diff-tree --no-commit-id --name-status -r"

# gl - git commit browser (enter for show, ctrl-d for diff, ` toggles sort)
# TODO: Add options to seatch all branchs and exact seatch
gl() {
  local out shas sha q k
  while out=$(
      git log --graph \
              --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr)%Creset by %C(bold blue)%an%C(yellow)%d%Creset' \
              --abbrev-commit --date=relative --color=always "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d --toggle-sort=\`); do
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
zinit depth'3' lucid light-mode for \
  trigger-load'!yarn;npm;node' \
    OMZP::nvm

####################
# RVM, Ruby, Rails #
####################
alias upgrade_rvm="rvm get stable && rvm requirements && rvm reload"
alias rvm_cheatsheat="start http://cheat.errtheblog.com/s/rvm"
alias rvm_known_rubys="rvm list known"
alias rc="rails console --sandbox"
alias gem_docs="yard server -g"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# TODO: make fast! -[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

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
# Compketion setup #
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
                   && upgrade_say 'RVM'    && upgrade_rvm       \
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

alias aws-whoami='aws sts get-caller-identity'

aws-ssh() {
  local save_profile="$AWS_PROFILE"
  if [[ "$1" != "" ]]; then
    export AWS_PROFILE="$1"
  fi

  aws ssm start-session --target "$(aws ec2 describe-instances --query "Reservations[].Instances[].[InstanceId,InstanceType,Tags[?Key==\`Name\`]|[0].Value,State.Name]" --output json | jq -r ".[]|@tsv" | grep --color=none 'running$' | fzf  | cut -f1)"

  if [[ $save_profile != "" ]]; then
    export AWS_PROFILE="$save_profile"
  else
    unset AWS_PROFILE
  fi
}

aws-login() {
   unset AWS_PROFILE
   local file_name="/tmp/$$"
   aws configure sso 2>&1 | tee "$file_name"
   export AWS_PROFILE="$(grep "ls \-\-profile" "$file_name" | cut -d" " -f5)"
   \rm "$file_name"
   aws-whoami
}

# Set the iTerm2 title
function title {
    echo -ne "\033]0;"$*"\007"
}

# Function to run on directory change
function chpwd {
  local title="$(pwd)"
  title="${title#"$HOME/work/"}"

  if [[ $title != "" ]]; then
    title "Git repo: $(echo $title | cut -d/ -f1)"
  else
    title "Default"
  fi
}
#
# Maccy
alias maccy-disable="defaults write org.p0deje.Maccy ignoreEvents true"
alias maccy-enable="defaults write org.p0deje.Maccy ignoreEvents false"

export PATH=".:$PATH"

echo " -----------------------------------------------------------"
