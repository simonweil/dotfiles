#!/usr/bin/env bash

#########################
# Internal functions
#########################
__aws_whoami() {
  aws sts get-caller-identity
}

#########################
# The AWS helpers
#########################
aws-ssm-port-forwarding() {
  local selected_instance=$(aws-ec2-select-instance)

  if [[ -z "$selected_instance" ]]; then
    echo "No instance selected." >&2
    return 1
  fi

  local instance_id=$(echo "$selected_instance" | jq -r '.id')
  local instance_name=$(echo "$selected_instance" | jq -r '.name')
  local local_port="${1:-5000}"

  echo "Starting port forwarding to instance: $instance_name ($instance_id)"
  echo "Remote port 80 → localhost:$local_port"

  aws ssm start-session \
    --target "$instance_id" \
    --document-name AWS-StartPortForwardingSession \
    --parameters "{\"portNumber\":[\"80\"],\"localPortNumber\":[\"$local_port\"]}"
}

aws-ec2-terminate-instances() {
  declare -A selected_instances

  while true; do
    local selected_instance=$(aws-ec2-select-instance)
    local instance_id=$(echo "$selected_instance" | jq -r '.id')
    local instance_name=$(echo "$selected_instance" | jq -r '.name')

    if [[ -z "$instance_id" || -z "$instance_name" ]]; then
      if [ ${#selected_instances[@]} -eq 0 ]; then
        echo "No instances selected for termination."
        return 1
      fi
      break # Exit loop if no selection is made and proceed to confirmation
    fi

    selected_instances["$instance_name"]="$instance_id"

    yellow="\033[33m"
    cyan="\033[36m"
    green="\033[32m"
    reset="\033[0m"

    echo "${yellow}Selected instance:${reset} ${instance_id} (${cyan}${instance_name}${reset})" >&2

    if ! __prompt_confirm "Do you want to select more instances?" "n"; then
        break
    fi
  done

  echo "You have selected the following instance(s) for termination:"
  for name in "${!selected_instances[@]}"; do
    id="${selected_instances[$name]}"
    echo " ${yellow}-${reset} ${id} (${cyan}${name}${reset})"
  done

  if __prompt_confirm "Are you sure you want to terminate the selected instance(s)?" "n"; then
    echo "${cyan}Terminating instances...${reset}"
    aws ec2 terminate-instances --instance-ids "${selected_instances[@]}"
    echo "${green}Instances terminated.${reset}"
  else
    echo "Operation aborted."
  fi
}

aws-ec2-select-instance() {
  local selected_instance=$(aws ec2 describe-instances --query "Reservations[].Instances[].[InstanceId,InstanceType,Tags[?Key==\`Name\`]|[0].Value,State.Name]" --output json | jq -r ".[]|@tsv" | grep --color=none 'running$' | fzf)

  local instance_id=$(echo "$selected_instance"  | cut -f1)
  local instance_name=$(echo "$selected_instance"  | cut -f3)

  # Use jq to safely create a JSON object
  jq -n --arg id "$instance_id" --arg name "$instance_name" \
    '{id: $id, name: $name}'
}

 aws-ssh() {
  local save_profile="$AWS_PROFILE"
  if [[ "$1" != "" ]]; then
    export AWS_PROFILE="$1"
  fi

  local selected_instance=$(aws-ec2-select-instance)

  local instance_id=$(echo "$selected_instance" | jq -r '.id')
  local instance_name=$(echo "$selected_instance" | jq -r '.name')

  yellow="\033[33m"
  cyan="\033[36m"
  green="\033[32m"
  reset="\033[0m"

  echo "${yellow}Connected to:${reset} ${instance_id} (${cyan}${instance_name}${reset})" >&2

  aws ssm start-session --target "$instance_id"

  if [[ $save_profile != "" ]]; then
    export AWS_PROFILE="$save_profile"
  else
    unset AWS_PROFILE
  fi
}

aws-update-account-in-config() {
  cat <<-"EOD"
This function is used to add an entry to ~/.aws/config so you can later use 'aa' or 'aws-change-account'
Set the region for the account, note it is not the sso region, that should not be changed.

EOD

  unset AWS_PROFILE
  aws configure sso

  echo
  echo "Now run 'aa' to change the profile to the account you need"
  echo
}

aws-change-account() {
  unset AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_ACCESS_KEY_ID
  if [[ "$1" != "" ]]; then
    profile="$1"
  else
    profile="$(aws configure list-profiles | grep -i --color=none superadmin | fzf)"
  fi

  export AWS_PROFILE="$profile"
}

aws-logout() {
  aws sso logout
  aws-exit-account
}

aws-exit-account() {
  unset AWS_PROFILE
  unset AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_ACCESS_KEY_ID
  chpwd
}

alias aws-whoami='aws sts get-caller-identity'
alias ati="aws-ec2-terminate-instances"
alias aa="aws-change-account"
alias ac="aws-console"
alias as="aws-ssh"

# Set the iTerm2 title
function title {
  echo -ne "\033]0;$*\007"
}

# Function to run on directory change
function chpwd {
  local git_path="$(pwd)"
  git_path="${git_path#"$HOME/work/"}"
  git_path="$(echo "$git_path" | cut -d/ -f1)"

  local aws_title=""
  if [[ -n $AWS_PROFILE ]]; then
     aws_title="AWS account: $(echo "$AWS_PROFILE" | cut -d- -f1-3)"
  fi

  local git_title=""
  if [[ "$git_path" != "" ]]; then
    git_title="Git repo: $git_path"
  fi

  local title
  if [[ -n $git_title ]]; then
    title="$git_title"
    if [[ -n $aws_title ]]; then
       title="$title ~ $aws_title"
    fi
  elif [[ -n $aws_title ]]; then
    title="$aws_title"
  else
    title="Default"
  fi

  title "$title"
}
chpwd
