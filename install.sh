#!/usr/bin/env bash

# install HomeBrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install all required homebrew formulas (Cask is first as it has dependencies for brew)
source setup-scripts/Caskfile
source setup-scripts/Brewfile
source setup-scripts/Brew-Gemfile
source setup-scripts/Nodefile
source setup-scripts/Pipfile

# Setup bash from brew
sudo sh -c 'echo "/usr/local/bin/bash" >> /etc/shells'
sudo sh -c 'echo "/usr/local/bin/zsh"  >> /etc/shells'
chsh -s /usr/local/bin/bash

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
ln -s $PWD/zshrc                ~/.zshrc
ln -s $PWD/bashrc               ~/.bashrc
ln -s $PWD/bash_profile         ~/.bash_profile
ln -s $PWD/pryrc                ~/.pryrc
ln -s $PWD/editorconfig         ~/.editorconfig # for the js beutifier vim plugin
ln -s $PWD/mackup.cfg           ~/.mackup.cfg
ln -s $PWD/tmux.conf            ~/.tmux.conf
mkdir ~/bin
ln -s $PWD/bin/git-meld         ~/bin/
ln -s $PWD/bin/find_stories.py  ~/bin/
ln -s $PWD/non-packaged-repos/emojify/emojify ~/bin/

# Set up ls colors
wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O $HOME/.dircolors


# For updating the submodules of janus and more
git submodule init
git submodule update --remote --merge

# OSX settings
setup-scripts/osx-setup.sh

# Karabiner setup (https://pqrs.org/osx/karabiner/)
setup-scripts/karabiner-import.sh

# Mackup setup all apps prefs (I use mackup to save apps settings stored in google drive to keep my private data)
#mackup restore
