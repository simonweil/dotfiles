#!/usr/local/bin/bash

# TODO: standard - update_* upgrade_*

###
# vim related
#
set -o vi # go into vi mode on the shell!!!
alias v="mvim --remote-silent "
alias update_neovim='brew reinstall --HEAD neovim'
alias vim='nvim'
alias vi='nvim'
export EDITOR='nvim'
###

# useful shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ..3="cd ../../.."

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
alias brew_wine_upgrade='brew upgrade wine --devel'
alias brew_desc="brew desc"
alias brew_cask="brew cask"
alias brew_formulas_that_depend_on="brew uses --recursive "
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# enable bash compleation
if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
  . $(brew --prefix)/share/bash-completion/bash_completion
fi

# python
alias pip_upgrade="pip install --upgrade setuptools && pip install --upgrade pip"
alias pip_update="pip list --outdated"

# git
alias git_grep='git log --grep "(NISITES-51" --pretty=oneline'
alias git_bad_files='find . -name ".DS_Store" -or -name "Thumbs.db"'
alias git_log="git log --graph --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr)%Creset by %C(bold blue)%an%C(yellow)%d%Creset' --abbrev-commit --date=relative" # add --all to see all branches and not only the checkedout branch
alias gp="git pull"
alias gf="git fetch"
alias gs="git status"
alias gd="git diff --ignore-space-at-eol -b -w --ignore-blank-lines"
alias git_commit_files="git diff-tree --no-commit-id --name-status -r"
alias git_bad_commit_messages="git log --oneline --since='last week' --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr)%Creset by %C(bold blue)%an%C(yellow)%d%Creset' --abbrev-commit --date=relative | grep -vE 'Merge (remote-tracking )?branch' | grep -vE 'NISITES-|AT-|KNSS-'"

# rake
alias rake_bower_install="rake bower:dsl:install"

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# submarine - automatic subtitles download
alias submarine="submarine --language=he "

# cheat
export CHEATCOLORS=true # add colores to cheat

# coreutils
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"

# node
alias node_list='npm -g list | grep "^[└|├]" | cut -d " " -f2 | cut -d"@" -f1'
export PATH="$HOME/bin:/usr/local/share/npm/bin:$PATH"

# todo.txt
alias t="todo.sh"
complete -F _todo t
export TODOTXT_DEFAULT_ACTION=ls


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
alias wine-heidisql="wine 'C:\Program Files\HeidiSQL\heidisql.exe' &"
alias wine-BC="wine start /UNIX ~/.wine/drive_c/Program\ Files/Beyond\ Compare\ 3/BCompare.exe &"
alias wine-ie8="wine 'C:\Program Files\Internet Explorer\iexplore' &"
alias wine-toad="WINEPREFIX='$HOME/.wine32' WINEARCH='win32' wine ~/.wine32/drive_c/Program\ Files/Quest\ Software/Toad\ for\ MySQL\ Freeware\ 7.0/toad.exe"
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
# WINEPREFIX="$HOME/.wine32" WINEARCH='win32' wine ~/Downloads/Quest_Toad-for-MySQL-Freeware_70.exe


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

####################
# general settings #
####################

alias update_all="npm outdated --quiet --depth=0 --global && pip_update && brew_update"
alias update_project="npm --quiet --depth=0 outdated && rake bower:list && bundle outdated"

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
eval $(dircolors -b $HOME/.dircolors)
# Another option:
# http://linux-sxs.org/housekeeping/lscolors.html
#export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
#export LS_COLORS='no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:'


##########################
# Other general settings #
##########################
export DISABLE_AUTO_TITLE=true # for tmux titles
alias tmux_attach="tmux -CC attach"

alias sites_up='nameservers=$(scutil --dns | grep nameserver | grep -v "127.0.0.1" | sort -u | cut -d":" -f2 | sed "s/ //g" | sort -u | tr "\n" "," | awk -F, "{ printf $1; for (i=2; i < NF; i++) printf \",\"$i   }"); sudo networksetup -setdnsservers Wi-Fi 127.0.0.1 && sudo networksetup -setdnsservers "Thunderbolt Ethernet" 127.0.0.1 && sudo ~/bin/dnschef.py --fakeipv6 ::1  --fakeip 10.25.1.10 --fakedomains *.local.*,*.local.*.*,*.local.*.*.*,*.local.*.*.*.*,*.*.local.*,*.*.local.*.*,*.*.local.*.*.*,*.*.local.*.*.*.* --nameserver $nameservers'
alias sites_down='sudo networksetup -setdnsservers "Wi-Fi" empty && sudo networksetup -setdnsservers "Thunderbolt Ethernet" empty'

[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

export PATH=".:$PATH"
