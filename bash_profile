#!/usr/local/bin/bash

###
# vim related
#
set -o vi # go into vi mode on the shell!!!
alias v="mvim --remote-silent "
###

# useful shortcuts
alias ..="cd .."
alias ld="ls -lh | grep '^d'"
alias ll="ls -lh"
alias ...="cd ../.."
alias ..3="cd ../../.."

alias bin="cd ~/bin"
alias dev="cd ~/Dev"
alias dev_sites="cd ~/Dev/www/top10sites"
alias dev_tracker="cd ~/Dev/www/tracker"
alias dev_lwcms="cd ~/Dev/www/lightweight-cms"

alias grep="grep --color=always "

# dev
alias apache_start="sudo apachectl  -k start"
alias apache_restart="sudo apachectl  -k restart"
alias apache_stop="sudo apachectl  -k stop"
alias apache_conf="cd /etc/apache2/"
alias apache_log="cd /var/log/apache2/"

# home brew
alias brew_update="brew update && brew outdated"
alias brew_wine_upgrade='brew upgrade wine --devel --use-gcc'
alias brew_desc="brew desc"
alias brew_cask="brew cask"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# enable bash compleation
if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
  . $(brew --prefix)/share/bash-completion/bash_completion
fi

# python
alias pip_update="pip install --upgrade distribute && pip install --upgrade pip"

# RVM, Ruby, Rails
alias rvm_update="rvm get latest && rvm requirements"
alias rvm_cheatsheat="start http://cheat.errtheblog.com/s/rvm"
source /Users/simonweil/.rvm/scripts/rvm

# RVM bash completion
[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"

# win apps
alias wine-heidisql="wine  ~/.wine/drive_c/Program\ Files/HeidiSQL/heidisql.exe &"
alias wine-BC="wine start /UNIX ~/.wine/drive_c/Program\ Files/Beyond\ Compare\ 3/BCompare.exe &"
alias wine-ie8="wine ~/.wine/drive_c/Program\ Files/Internet\ Explorer/iexplore.exe &"


# optional wine dependencies: brew install libntlm mpg123 samba
# run as 32 bit for dotnet35sp1: export WINEPREFIX="$HOME/.wine32"; export WINEARCH='win32'; winecfg
# install dotnet35sp1: winetricks -q msxml6 mfc42 gdiplus corefonts # not this dotnet35sp1
# export WINEDLLOVERRIDES=ngen.exe,mscorsvw.exe=b
# wine ~/Downloads/dotnetfx35setup.exe 
# wineboot --update
# wine /Users/simonweil/Downloads/Quest_Toad-for-MySQL-Freeware_63.exe

# git
alias git_grep='git log --grep "(NISITES-51" --pretty=oneline'
alias git_bad_files='find . -name ".DS_Store" -or -name "Thumbs.db"'
alias git_log="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%Creset' --abbrev-commit --date=relative --all"
alias gp="git pull"
alias gs="git status"


# rake
alias rake_bower_install="rake bower:dsl:install"

#
# general settings
#

alias update_all="npm -g outdated; brew_update"
alias update_project="npm outdated && rake bower:list && bundle outdated"

# http://www.kirsle.net/wizards/ps1.html
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#export PS1="\[$(tput setaf 6)\]\u\[$(tput setaf 3)\]:\[$(tput setaf 6)\]\w\[$(tput setaf 2)\]\$(branch=\`git branch 2> /dev/null | grep '^*' | cut -c3-\`; if [[ \"\$branch\" != \"\" ]]; then echo \" (\$branch) >\" ; fi)\[$(tput setaf 3)\]> \[$(tput sgr0)\]"
export CLICOLOR=""

export PATH="$HOME/bin:/usr/local/share/npm/bin:$PATH"

# Add all private configuration
source ~/.dotfiles/bash_profile.private

if [ -f $(brew --prefix)/share/liquidprompt  ]; then
  . $(brew --prefix)/share/liquidprompt
fi
