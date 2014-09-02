#!/usr/local/bin/bash

###
# vim related
#
set -o vi # go into vi mode on the shell!!!
alias v="mvim --remote-silent "
###

# useful shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ..3="cd ../../.."

# http://linux-sxs.org/housekeeping/lscolors.html
export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
#export LS_COLORS='no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:'
alias ld="ls --color -lh | grep '^d'"
alias ll="ls --color -lh"
alias ls="ls --color"

alias bin="cd ~/bin"
alias dev="cd ~/Dev"
alias dev_sites="cd ~/Dev/www/top10sites"
alias dev_tracker="cd ~/Dev/www/tracker"
alias dev_lwcms="cd ~/Dev/www/lightweight-cms"

alias grep="grep --color=always -i "

# dev
alias apache_start="sudo apachectl -k start"
alias apache_restart="sudo apachectl -k restart"
alias apache_stop="sudo apachectl -k stop"
alias apache_conf="cd /etc/apache2/"
alias apache_log="cd /var/log/apache2/"

# homebrew
alias brew_update="brew update && brew outdated"
alias brew_wine_upgrade='brew upgrade wine --devel --use-gcc'
alias brew_desc="brew desc"
alias brew_cask="brew cask"
alias brew_formulas_that_depend_on="brew uses --recursive "
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# enable bash compleation
if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
  . $(brew --prefix)/share/bash-completion/bash_completion
fi

# python
alias pip_update="pip install --upgrade setuptools && pip install --upgrade pip"

####################
# RVM, Ruby, Rails #
####################
alias rvm_update="rvm get stable && rvm requirements && rvm reload"
alias rvm_cheatsheat="start http://cheat.errtheblog.com/s/rvm"
alias rvm_known_rubys="rvm list known"
alias rc="rails console --sandbox"
alias gem_docs="yard server -g"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# RVM bash completion
[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"


############
# win apps #
############
alias wine-heidisql="WINEPREFIX='$HOME/.wineheidi' wine ~/.wine/drive_c/Program\ Files/HeidiSQL/heidisql.exe &"
alias wine-BC="wine start /UNIX ~/.wine/drive_c/Program\ Files/Beyond\ Compare\ 3/BCompare.exe &"
alias wine-ie8="wine ~/.wine/drive_c/Program\ Files/Internet\ Explorer/iexplore.exe &"
alias wine-toad="WINEPREFIX='$HOME/.wine32' WINEARCH='win32' wine ~/.wine32/drive_c/Program\ Files/Quest\ Software/Toad\ for\ MySQL\ Freeware\ 7.0/toad.exe"
alias wine-npp="wine ~/.wine/drive_c/noinstall/npp.6.5.5.bin/notepad++.exe"


# Old:
# optional wine dependencies: brew install libntlm mpg123 samba
# run as 32 bit for dotnet35sp1: export WINEPREFIX="$HOME/.wine32"; export WINEARCH='win32'; winecfg
# install dotnet35sp1: winetricks -q msxml6 mfc42 gdiplus corefonts # not this dotnet35sp1
# export WINEDLLOVERRIDES=ngen.exe,mscorsvw.exe=b
# wine ~/Downloads/dotnetfx35setup.exe
# wineboot --update
# wine /Users/simonweil/Downloads/Quest_Toad-for-MySQL-Freeware_63.exe

# New:
# run as 32 bit for dotnet35sp1: export WINEPREFIX="$HOME/.wine32"; export WINEARCH='win32'; winecfg
# winetricks dotnet40
# wine /Users/simonweil/Downloads/Quest_Toad-for-MySQL-Freeware_70.exe

# git
alias git_grep='git log --grep "(NISITES-51" --pretty=oneline'
alias git_bad_files='find . -name ".DS_Store" -or -name "Thumbs.db"'
alias git_log="git log --graph --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr)%Creset by %C(bold blue)%an%C(yellow)%d%Creset' --abbrev-commit --date=relative" # add --all to see all branches and not only the checkedout branch
alias gp="git pull"
alias gs="git status"


# rake
alias rake_bower_install="rake bower:dsl:install"

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# submarine - automatic subtitles download
alias submarine="submarine --language=he "

# cheat
export CHEATCOLORS=true # add colores to cheat

# coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# node
alias node_list='npm -g list | grep "^[└|├]" | cut -d " " -f2 | cut -d"@" -f1'
export PATH="$HOME/bin:/usr/local/share/npm/bin:$PATH"

#
# general settings
#

alias update_all="npm -global -quiet outdated; brew_update"
alias update_project="npm -quiet outdated && rake bower:list && bundle outdated"

# http://www.kirsle.net/wizards/ps1.html
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#export PS1="\[$(tput setaf 6)\]\u\[$(tput setaf 3)\]:\[$(tput setaf 6)\]\w\[$(tput setaf 2)\]\$(branch=\`git branch 2> /dev/null | grep '^*' | cut -c3-\`; if [[ \"\$branch\" != \"\" ]]; then echo \" (\$branch) >\" ; fi)\[$(tput setaf 3)\]> \[$(tput sgr0)\]"
export CLICOLOR=""

# Add all private configuration
source ~/.dotfiles/bash_profile.private

if [ -f $(brew --prefix)/share/liquidprompt  ]; then
  . $(brew --prefix)/share/liquidprompt
fi

# Set ls colors (update from https://github.com/trapd00r/LS_COLORS)
# Another theme is: https://github.com/seebi/dircolors-solarized
eval $(dircolors -b $HOME/.dircolors)
