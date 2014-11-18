#!/usr/bin/env bash

brew bundle setup-scripts/Brewfile
brew bundle setup-scripts/Caskfile
brew bundle setup-scripts/Brew-Gemfile

# RVM
curl -sSL https://get.rvm.io | bash -s stable --ruby --autolibs=brew

# Global gems
#rvm @global do gem install tmuxinator

# janus
curl -Lo- https://bit.ly/janus-bootstrap | bash

# Setup all symlinks
ln -s $PWD/vimrc.before         ~/.vimrc.before
ln -s $PWD/vimrc.after          ~/.vimrc.after
ln -s $PWD/liquidpromptrc       ~/.liquidpromptrc
ln -s $PWD/janus                ~/.janus
ln -s $PWD/gitconfig            ~/.gitconfig
ln -s $PWD/bashrc               ~/.bashrc
ln -s $PWD/bash_profile         ~/.bash_profile
ln -s $PWD/pryrc                ~/.pryrc
ln -s $PWD/editorconfig         ~/.editorconfig # for the js beutifier vim plugin
mkdir ~/bin
ln -s $PWD/bin/git-meld         ~/bin/git-meld
ln -s $PWD/bin/find_stories.py  ~/bin/find_stories.py
ln -s $PWD/mackup.cfg           ~/.mackup.cfg
ln -s $PWD/tmux.conf            ~/.tmux.conf

# Set up ls colors
wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O $HOME/.dircolors

# For updating the submodules of janus and more
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule update --remote --merge

# OSX settings
setup-scripts/osx-setup.sh

# Karabiner setup (https://pqrs.org/osx/karabiner/)
setup-scripts/karabiner-import.sh

# Mackup setup all apps prefs (I use mackup to save apps settings stored in google drive to keep my private data)
mackup restore
