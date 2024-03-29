#!/usr/bin/env bash

set -o errexit

# Mainly for python3 tests
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# do not update brew every time brew command is used
export HOMEBREW_NO_AUTO_UPDATE=1

# install HomeBrew
if hash brew 2>/dev/null; then
  echo "Brew is already installed"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# install all required homebrew formulas (Cask is first as it has dependencies for brew)
source ./setup-scripts/Caskfile
source ./setup-scripts/Brewfile
source ./setup-scripts/Brew-Gemfile
source ./setup-scripts/Nodefile
source ./setup-scripts/Pipfile
source ./setup-scripts/Nativefierfile
#source ./setup-scripts/MacOSfile - doesn't work anymore :/

# Setup bash from brew
sudo sh -c 'echo "/opt/homebrew/bin/bash" >> /etc/shells'
sudo sh -c 'echo "/opt/homebrew/bin/zsh"  >> /etc/shells'
chsh -s /opt/homebrew/bin/zsh

# NVM
mkdir ~/.nvm

# For updating the submodules
git submodule init
git submodule update --remote --merge

prompt_confirm() {
  while true; do
    read -r -n 1 -p "${1:-Continue?} [y/n]: " REPLY
    case $REPLY in
      [yY]) echo ; return 0 ;;
      [nN]) echo ; return 1 ;;
      *) printf " \033[31m %s \n\033[0m" "invalid input"
    esac
  done
}

link_files () {
  local dest_file=$1
  local soft_link=$2

  [[ -h $soft_link ]] && rm $soft_link

  if [[ -r $soft_link && ! -d $soft_link ]]; then
    echo "the file $soft_link exists"
    ls -lh "$soft_link"
    if prompt_confirm "Delete it?"; then
      cp "$soft_link" "${soft_link}.$(date +"%Y-%M-%d-%H-%M-%S")"
      rm "$soft_link"
    else
      echo "Not creating a soft link for $dest_file."
      return
    fi
  fi

  echo "linking '$soft_link' to '$dest_file'"
  ln -s $dest_file $soft_link
}

# Create the bin dir if it doesn't exist yet
[[ ! -d ~/bin ]] && mkdir ~/bin

# Setup all symlinks
link_files $PWD/config/              ~/.config
link_files $PWD/liquidpromptrc       ~/.liquidpromptrc
link_files $PWD/gitconfig            ~/.gitconfig
link_files $PWD/zshrc                ~/.zshrc
link_files $PWD/bashrc               ~/.bashrc
link_files $PWD/bash_profile         ~/.bash_profile
link_files $PWD/pryrc                ~/.pryrc
link_files $PWD/editorconfig         ~/.editorconfig # for the js beutifier vim plugin
link_files $PWD/mackup.cfg           ~/.mackup.cfg
link_files $PWD/tmux.conf            ~/.tmux.conf
link_files $PWD/bin/aws-console      ~/bin/
link_files $PWD/bin/find_stories.py  ~/bin/
link_files $PWD/non-packaged-repos/emojify/emojify ~/bin/
link_files $PWD/non-packaged-repos/LS_COLORS/LS_COLORS ~/.dircolors
link_files $PWD/nvimrc               ~/.vimrc
link_files $PWD/nvimrc               $PWD/config/nvim/init.vim
link_files $PWD/non-packaged-repos/vim-plug/plug.vim $PWD/config/nvim/autoload/plug.vim
link_files $PWD/sshconfig            ~/.ssh/config
link_files $PWD/rvmrc                ~/.rvmrc
link_files $PWD/terraformrc          ~/.terraformrc

# OSX settings
source setup-scripts/osx-setup.sh

# Karabiner setup (https://pqrs.org/osx/karabiner/)
#source setup-scripts/karabiner-import.sh - need to fix!

echo "Done"
