#!/usr/bin/env bash

echo " -----------------------------------------------------------"

###
# vim related
#
set -o vi # go into vi mode on the shell!!!
alias v="mvim --remote-silent "
alias upgrade_neovim="   workon neovim \
                      && pip install --upgrade pynvim pylama_pylint pylama \
                      && workon neovim3 \
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

# brew installed utils
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"

# useful shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."

# cd into whatever is the forefront Finder window.
cdf() {  # short for cdfinder
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" || return
}

alias ld="ls --color -lhA | grep '^d'"
alias ll="ls --color -lhF"
alias lla="ls --color -lhFA"
alias ls="ls --color"

alias bin="cd ~/bin"
alias dev="cd ~/Dev"
alias grep="grep --color=always -i "

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias myip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print \$2}'"

# dev
alias apache_start="sudo apachectl -k start"
alias apache_restart="sudo apachectl -k restart"
alias apache_stop="sudo apachectl -k stop"
alias apache_conf="cd /etc/apache2/"
alias apache_log="cd /var/log/apache2/"

# homebrew
alias update_brew="brew update && brew outdated"
alias upgrade_brew="brew upgrade && brew outdated"
alias upgrade_wine='if [[ $(brew outdated wine) ]]; then brew upgrade wine; fi'
alias brew_desc="brew desc"
alias brew_cask="brew cask"
alias brew_formulas_that_depend_on="brew uses --recursive "
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# enable bash compleation
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"

# source kubectl and minikube bash completion
source <(kubectl completion bash)
source <(minikube completion bash)


#
# python
#
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/usr/local/opt/python@2/bin:$PATH"
alias upgrade_pip="    pip install --upgrade setuptools \
                    && pip install --upgrade pip        \
                    && pip install --upgrade virtualenv virtualenvwrapper \
                    && for pkg in \$(pip list --outdated 2> /dev/null | tail -n +3 | awk '{ print \$1 }' | grep -v \"^pip\\\$\"); do pip install -U \$pkg; done"
alias update_pip="pip list --outdated"

alias upgrade_pip3="   pip3 install --upgrade setuptools wheel \
                    && pip3 install --upgrade pip        \
                    && pip3 install --upgrade virtualenv virtualenvwrapper \
                    && for pkg in \$(pip3 list --outdated 2> /dev/null | tail -n +3 | awk '{ print \$1 }' | grep -v \"^pip3\\\$\"); do pip3 install -U \$pkg; done"
alias update_pip3="pip3 list --outdated"

# Setup virtual env
export WORKON_HOME=~/work/virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# For installing dependencies
export LDFLAGS="$LDFLAGS -L/usr/local/opt/libgeoip/lib/ -L/usr/local/opt/openssl/lib -L/usr/local/opt/libxml2/lib -L$(brew info libmemcached | grep --color=none "\*$" | awk '{ print $1 }')/lib/"
export CPPFLAGS="$CPPFLAGS -I/usr/local/include/ -I/usr/local/opt/openssl/include -I/usr/local/opt/libxml2/include/libxml2/ -I$(brew info libmemcached | grep --color=none "\*$" | awk '{ print $1 }')/include/"
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
alias gcm-ec='git checkout master-ec'
alias git_cherrypick='git cherry-pick --signoff -x'
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

# rake
alias rake_bower_install="rake bower:dsl:install"

# autojump
[ -f "$(brew --prefix)/etc/profile.d/autojump.sh" ] && . "$(brew --prefix)/etc/profile.d/autojump.sh"

# fzf #
export FZF_COMPLETION_TRIGGER=',,'
export FZF_COMPLETION_OPTS='-m --ansi'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# cheat
export CHEATCOLORS=true # add colores to cheat

# node
alias node_list='npm -g list --depth=0'
export PATH="$HOME/bin:/usr/local/share/npm/bin:$PATH"
alias update_project_node="npm outdated --quiet --depth=0"
alias update_node="update_project_node --global"
alias upgrade_project_node="npm update"
alias upgrade_node="nvm install node --latest-npm && ~/.dotfiles/setup-scripts/Nodefile && upgrade_project_node --global"
# add gulp completion
eval "$(gulp --completion=bash)"

# todo.txt
alias t="todo.sh"
complete -F _todo t
export TODOTXT_DEFAULT_ACTION=ls


####################
# RVM, Ruby, Rails #
####################
alias upgrade_rvm="rvm get stable && rvm requirements && rvm reload"
alias rvm_cheatsheat="start http://cheat.errtheblog.com/s/rvm"
alias rvm_known_rubys="rvm list known"
alias rc="rails console --sandbox"
alias gem_docs="yard server -g"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# RVM bash completion
[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"


# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && source "$(brew --prefix)/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && source "/usr/local/opt/nvm/etc/bash_completion.d/nvm"


############
# win apps #
############
alias wine-heidisql="wine 'C:\Program Files\HeidiSQL\heidisql.exe' &"
alias wine-BC="wine start /UNIX ~/.wine/drive_c/Program\ Files/Beyond\ Compare\ 3/BCompare.exe &"
alias wine-ie8="wine 'C:\Program Files\Internet Explorer\iexplore' &"
alias wine-toad="WINEPREFIX='$HOME/.wine32' WINEARCH='win32' wine 'C:\\Program Files\Quest Software\Toad for MySQL Freeware 7.3\toad.exe'"
alias wine-npp="wine 'C:\Program Files\Notepad++\notepad++.exe' &"


# Old:
# optional wine dependencies: brew install libntlm mpg123 samba
# run as 32 bit for dotnet35sp1: export WINEPREFIX="$HOME/.wine32"; export WINEARCH='win32'; winecfg
# install dotnet35sp1: winetricks -q msxml6 mfc42 gdiplus corefonts # not this dotnet35sp1
# export WINEDLLOVERRIDES=ngen.exe,mscorsvw.exe=b
# wine ~/Downloads/dotnetfx35setup.exe
# wineboot --update
# wine /Users/simonweil/Downloads/Quest_Toad-for-MySQL-Freeware_63.exe

# New:
# run as 32 bit for dotnet35sp1: WINEPREFIX="$HOME/.wine32" WINEARCH='win32' winecfg
# WINEPREFIX="$HOME/.wine32" WINEARCH='win32' winetricks dotnet40
# WINEPREFIX="$HOME/.wine32" WINEARCH='win32' wine ~/Downloads/ToadforMySQL_Freeware_7.3.1.3290.exe


###########
# History #
###########

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups

# timestamps for bash history. www.debian-administration.org/users/rossen/weblog/1
# saved for later analysis
export HISTTIMEFORMAT='%F %T '

# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd;exit:man *:history:date:* --help"

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

alias update_all="update_node; update_pip && update_pip3 && update_macos && update_brew && echo -e \"\$(date)\\n\""
alias upgrade_all="   upgrade_say 'MAC'    && upgrade_macos     \
                   && upgrade_say 'node'   && upgrade_node      \
                   && upgrade_say 'Wine'   && upgrade_wine      \
                   && upgrade_say 'Brew'   && upgrade_brew      \
                   && upgrade_say 'pip'    && upgrade_pip       \
                   && upgrade_say 'pip3'   && upgrade_pip3      \
                   && source ~/.dotfiles/setup-scripts/Pipfile  \
                   && upgrade_say 'neovim' && upgrade_neovim    \
                   && upgrade_say 'RVM'    && upgrade_rvm       \
                   && upgrade_say 'Dotfiles (all submodules)' && upgrade_submodules \
                   && echo 'Done upgrading.'"
alias update_project="update_node_project && rake bower:list && bundle outdated"

# http://www.kirsle.net/wizards/ps1.html
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#export PS1="\[$(tput setaf 6)\]\u\[$(tput setaf 3)\]:\[$(tput setaf 6)\]\w\[$(tput setaf 2)\]\$(branch=\`git branch 2> /dev/null | grep '^*' | cut -c3-\`; if [[ \"\$branch\" != \"\" ]]; then echo \" (\$branch) >\" ; fi)\[$(tput setaf 3)\]> \[$(tput sgr0)\]"
export CLICOLOR=""

# Add all private configuration
source ~/.dotfiles/bash_profile.private

if [ -f $(brew --prefix)/share/liquidprompt ]; then
  . $(brew --prefix)/share/liquidprompt
fi

# Set ls colors (update from https://github.com/trapd00r/LS_COLORS)
# Another theme is: https://github.com/seebi/dircolors-solarized
eval $(dircolors -b $HOME/.dotfiles/non-packaged-repos/LS_COLORS/LS_COLORS)
# Another option:
# http://linux-sxs.org/housekeeping/lscolors.html

# Marker - for command line bookmarks
# https://github.com/pindexis/marker - clone the repo when iTerm 2.9 is released
#[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"
echo " - Enable marker"

##########################
# Other general settings #
##########################
export DISABLE_AUTO_TITLE=true # for tmux titles
alias tmux_attach="tmux -CC attach"

alias sites_up='nameservers=$(scutil --dns | grep nameserver | grep -v "127.0.0.1" | sort -u | cut -d":" -f2 | sed "s/ //g" | sort -u | tr "\n" "," | awk -F, "{ printf $1; for (i=2; i < NF; i++) printf \",\"$i   }"); sudo networksetup -setdnsservers Wi-Fi 127.0.0.1 && sudo networksetup -setdnsservers "Thunderbolt Ethernet" 127.0.0.1 && sudo ~/bin/dnschef.py --fakeipv6 ::1  --fakeip 10.25.1.10 --fakedomains *.local.*,*.local.*.*,*.local.*.*.*,*.local.*.*.*.*,*.*.local.*,*.*.local.*.*,*.*.local.*.*.*,*.*.local.*.*.*.* --nameserver $nameservers'
alias sites_down='sudo networksetup -setdnsservers "Wi-Fi" empty && sudo networksetup -setdnsservers "Thunderbolt Ethernet" empty'

[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

export PATH=".:$PATH"

echo " -----------------------------------------------------------"
