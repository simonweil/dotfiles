#!/usr/bin/env bash

alias git_log="git log --graph --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr)%Creset by %C(bold blue)%an%C(yellow)%d%Creset' --abbrev-commit --date=relative" # add --all to see all branches and not only the checkedout branch
alias git_latest_branches="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

alias gp="git pull --rebase=merges"
alias gpush="git push --set-upstream origin HEAD" # Push current branch to origin with same branch name and set as tracking branch
alias gf="git fetch --all --prune && git fetch --tags --force && git fetch --tags --prune-tags"
alias gs="git status"
alias gde="git diff --ignore-space-at-eol -b -w --ignore-blank-lines"
alias gd="gde --no-ext-diff"
alias gdo="gd origin/\$(git rev-parse --abbrev-ref HEAD)..HEAD"

alias gc-='git checkout -'
alias gcd='git checkout develop'
alias gcs='git checkout staging'
alias gcm='git checkout master'
alias gcp='git cherry-pick --signoff -x'

alias glo='gl origin/$(git rev-parse --abbrev-ref HEAD)'
alias grh='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'

git-select-branch() {
  local BRANCH EXACT="--exact" SHOW_ALL=0 RED="\e[31m" COLOR_RESET="\e[0m"

  while [[ "$#" -gt 0 ]]; do
    case $1 in
      -a|--all)
        SHOW_ALL=1
        shift
        ;;
      -f|--fuzzy)
        unset EXACT
        shift
        ;;
      -h|--help)
        echo "Usage:"
        printf "\t-a, --all\tShow both local and remote refs\n"
        printf "\t-f, --fuzzy\tFuzzy search instead of the default exact search\n"
        return 0
        ;;
      *)
        echo "Unknown option: $1"
        echo "Usage: gc [-a|--all] [-f|--fuzzy]"
        return 1
        ;;
    esac
  done

  if [[ $SHOW_ALL -eq 1 ]]; then
    # Interactively choose a branch to checkout
    BRANCHES="$(git branch -a)"
    # Remove leading and trailing spaces
  else
    BRANCHES=$(git for-each-ref --sort=-committerdate refs/heads --format='%(refname:short)')
  fi

  BRANCH="$(echo -e "${RED}cancel branch selection${COLOR_RESET}\n$BRANCHES" \
    | fzf $EXACT --ansi -i --border --header "Select a branch (or interrupt to exit)" \
    | sed -e "s#^\s*remotes/[^/]*/##" \
  )"

  BRANCH="$(echo -e "${BRANCH}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

  # Remove leading and trailing spaces
  BRANCH="$(echo -e "${BRANCH}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

  echo "$BRANCH"
}

gc() {
  BRANCH="$(git-select-branch "$@")"

  # Graceful exit
  if [[ "$BRANCH" == "cancel branch selection" || -z "$BRANCH" ]]; then
    echo "Cancelled checkout."
    return 0
  fi

  git checkout "$BRANCH"

  # Setup remote tracking if it isn't yet setup
  if [[ ! $(git rev-parse --symbolic-full-name --abbrev-ref "@{u}" 2> /dev/null) ]]; then
    git branch --set-upstream-to="origin/$BRANCH" "$BRANCH"
  fi
}

git-remove-branch() {
  local BRANCH="$(git-select-branch "$@")"

  # Graceful exit
  if [[ "$BRANCH" == "cancel branch selection" || -z "$BRANCH" ]]; then
    echo "Cancelled branch deletion."
    return 0
  fi

  git branch -D "$BRANCH" || echo "Couldn't delete branch locally"
  git push origin --delete "$BRANCH" || echo "Couldn't delete remote branch"
}
alias grb="git-remove-branch"

# gl - git commit browser (enter for show, ctrl-d for diff, ` toggles sort)
gl() {
  local out shas sha q k git_user_name

  while getopts "me" opt; do
    case $opt in
      m) # Shortcut for "me". Only show your commits.
        git_user_name="$(git config --get user.name)"
        ;;
      e) # Searches for the exact wording.
        local exact="--exact"
        ;;
      \?)
        return 1
        ;;
    esac
  done

  shift $((OPTIND - 1))  # Shifts the positional parameters to exclude the flags

  while out=$(
      git log --graph \
              --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr)%Creset by %C(bold blue)%an%C(yellow)%d%Creset' \
              --abbrev-commit --date=relative --color=always --author="$git_user_name" "$@" |
      fzf $exact --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d --toggle-sort=\`
      ); do
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
