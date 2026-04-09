#!/usr/bin/env zsh

echo " -----------------------------------------------------------"


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

# Setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Setup virtual env
export VENV_HOME="$HOME/.venvs/"
source $VENV_HOME/local/bin/activate

# For installing dependencies
export LDFLAGS="$LDFLAGS -L$HOMEBREW_APP_PREFIX/libgeoip/lib/ -L$HOMEBREW_APP_PREFIX/openssl@1.1/lib -L$HOMEBREW_APP_PREFIX/libxml2/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/include/ -I$HOMEBREW_APP_PREFIX/openssl@1.1/include -I$HOMEBREW_APP_PREFIX/libxml2/include/libxml2/"
export PKG_CONFIG_PATH="$HOMEBREW_APP_PREFIX/libffi/lib/pkgconfig:$HOMEBREW_APP_PREFIX/openssl@1.1/lib/pkgconfig"
export PYCURL_SSL_LIBRARY=openssl
export PATH="$HOMEBREW_APP_PREFIX/openssl@1.1/bin:$PATH"


#
# git
#
# TODO: move to ./helpers/git_helpers.sh
alias git_bad_files='find . -name ".DS_Store" -or -name "Thumbs.db"'
alias git_log_all="git_log --branches --remotes --tags --decorate"

git-remove-old-branches() {
  # Fetch updates and prune stale branches
  gf

  # Removing branches that are gone on the remote
  git branch -vv --no-color | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D

  # Remove local branches not committed to in a certain amount of time
  git for-each-ref --format '%(refname:short) %(committerdate:raw) %(upstream:track)' refs/heads/ | while read branch last_commit_epoch upstream_track; do
    local current_epoch=$(date +%s)
    local deletion_threshold='3 months ago'
    local deletion_threshold_epoch="$(date --date="$deletion_threshold" +%s)"

    # Compare the last commit date of the branch to the deletion threshold
    if [[ $last_commit_epoch -lt $deletion_threshold_epoch ]]; then
      # Check if the branch has unpushed commits or no upstream set
      if [[ $upstream_track =~ ahead || -z "$upstream_track" ]]; then
        echo "Branch '$branch' has unpushed commits or no upstream set. Not deleting."
      else
        echo "Deleting $branch because its last commit was over $deletion_threshold."
        # git branch -D $branch
        # TODO: ask for approval before deletion
      fi
    fi
  done
}

alias git_commit_files="git diff-tree --no-commit-id --name-status -r"
alias t='git commit -m "tmp [no ci]"'

alias gl_exact='gl -e'
alias gl_author='gl -m'


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
source <(fzf --zsh)


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
  source helpers/terminal_helpers.sh

###############
# vim related #
###############
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

#
# Maccy
alias maccy-disable="defaults write org.p0deje.Maccy ignoreEvents true"
alias maccy-enable="defaults write org.p0deje.Maccy ignoreEvents false"

export PATH=".:$PATH:/usr/local/bin/"

echo " -----------------------------------------------------------"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
