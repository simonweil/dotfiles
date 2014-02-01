ln -s $PWD/vimrc.before ~/.vimrc.before
ln -s $PWD/vimrc.after ~/.vimrc.after
ln -s $PWD/liquidpromptrc ~/.liquidpromptrc
ln -s $PWD/janus ~/.janus
ln -s $PWD/gitconfig ~/.gitconfig
ln -s $PWD/bashrc ~/.bashrc
ln -s $PWD/bash_profile ~/.bash_profile
ln -s $PWD/pryrc ~/.pryrc
mkdir ~/bin
ln -s $PWD/bin/git-meld  ~/bin/git-meld

# For updating the submodules of janus
git submodule init
git submodule update
