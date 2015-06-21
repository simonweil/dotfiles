#!/usr/bin/env zsh

source $(brew --prefix)/share/antigen.zsh

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  ############################################################
  # Bundles from the default repo (robbyrussell's oh-my-zsh) #
  ############################################################
  # Load library only
  autojump

  # completion
  autopep8
  bower
  brew-cask
  celery
  compleat
  django
  docker
  fabric
  gem
  git-flow-avh
  pep8
  pip
  python
  vagrant

  bundler     # completion + aliases + wrapper for gems - see readme for more info
  colored-man # color for man
  colorize    # colorize file contents
  node        # Open the node api for your current version to the optional section.
  jira        # If you use Rapid Board, set: JIRA_RAPID_BOARD="true" in you .zshrc
              # Setup: cd to/my/project
              #        echo "https://name.jira.com" >> .jira-url
              # Usage: jira           # opens a new issue
              #        jira ABC-123   # Opens an existing issue
  rails       # completion including some aliases
  rvm         # completion including some aliases
  sublime     # aliases
  urltools    # aliases

  #virtualenv  # adds the env to the prompt
  virtualenvwrapper # activate virtual env automaticlly

  # check if we want this
  #ruby

  # vim
  #vim-interaction

  # not for OSX
  #command-not-found

  # Syntax highlighting bundle.
  zsh-users/zsh-syntax-highlighting

  # nicoulaj's moar completion files for zsh
  zsh-users/zsh-completions src

  # ZSH port of Fish shell's history search feature.
  zsh-users/zsh-history-substring-search
EOBUNDLES

export DEFAULT_USER=simonweil
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv virtualenv history time)
#POWERLEVEL9K_MODE='awesome-patched'
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#antigen theme bhilburn/powerlevel9k powerlevel9k
#antigen theme dritter/powerlevel9k powerlevel9k --branch=dritter/prezto

#antigen theme agnoster
antigen bundle nojhan/liquidprompt

# Vim like bindings plugin. Need to run after theme, so mode indicator
# can be set, if the theme didn't already set it.
#antigen bundle sharat87/zsh-vim-mode

# Tell antigen that you're done.
antigen apply

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
