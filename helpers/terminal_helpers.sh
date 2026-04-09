#!/usr/bin/env bash

source "$(dirname "$0")/color_definitions.sh"
source "$(dirname "$0")/aws_helpers.sh"
source "$(dirname "$0")/git_helpers.sh"
source "$(dirname "$0")/terraform_helpers.sh"

#########################
# Internal functions
#########################
__prompt_confirm() {
  local default_choice=${2}
  local prompt_options="y/n"

  if [[ "$default_choice" == "y" ]]; then
    prompt_options="Y/n"
  elif [[ "$default_choice" == "n" ]]; then
    prompt_options="y/N"
  fi

  local prompt_message="${1:-Continue?} [$prompt_options]: "

  while true; do
    echo -n "$prompt_message"
    read -r REPLY
    echo

    REPLY=${REPLY:-$default_choice}

    case $REPLY in
      [yY]) return 0 ;;
      [nN]) return 1 ;;
      *) printf " \033[31m %s \n\033[0m" "invalid input";;
    esac
  done
}

__is_an_app_dir() {
  grep -q 'services = {' settings.tf 2> /dev/null && echo "yes" || echo "no"
}


__is_a_running_tf_dir() {
  pwd | grep -q '/terraform/accounts/' && echo "yes" || echo "no"
}


__prepare_terraform_directory() {
  local generate_templates=true

  local pass_params=()
  while [[ $# -gt 0 ]]; do
    case $1 in
      -s|--skip-template-generation)
        generate_templates=false
        shift
        ;;
      -g|--debug)
        pass_params=("${pass_params[@]}" "$1")
        shift
        ;;
      *)
        echo "Unknown option $1"
        return 1
        ;;
    esac
  done

  # Verify this is a TF dir
  if [[ $(__is_a_running_tf_dir) == "no" ]]; then
    echo "Error: Run this command in a working Terraform directory (in 'accounts/')"
    return 1
  elif [[ ! -f settings.tf ]]; then
    echo "Warning: no settings.tf file exists, this is probably not an account or application directory"
  fi

  # Add missing softlinks if it is a tenant directory
  if [[ $(__is_an_app_dir) == "yes" ]]; then
    echo "This is an app dir, adding missing symlinks..."
    echo

    ln -s ../../../app_blueprint/* . 2>&1 | grep -v 'File exists'
  else
    echo "This is an account or meta dir, for now do nothing."
    echo
  fi

  if $generate_templates; then
    genenrate_terraform_code || return $?
  else
    echo -e "\nINFO: Skipping code generation\n"
  fi
}

__check_ip_from_curl() {
    local urls=("$@")
    local response

    # Regular expression for a valid IPv4 address
    local ipv4_regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$'

    for url in "${urls[@]}"; do
        response=$(curl -s "$url")
        if [[ $response =~ $ipv4_regex ]]; then
            echo "$response"
            return 0
        fi
    done

    echo "No valid IP found"
    return 1
}

__check_connection_to_aws() {
  local vpn_status="$(scutil --nc status "Cato Networks VPN" | head -n1)"
  local public_ip="$(__check_ip_from_curl 'https://api.ipify.org' 'https://checkip.amazonaws.com' 'https://ifconfig.me')"

  if { [[ "$vpn_status" == "Connected" ]] || [[ "$public_ip" == "31.154.25.242" ]]; } && (__aws_whoami > /dev/null 2>&1) ; then
      echo "${GREEN}You have access to AWS${ENDCOLOR}"
  else
      echo  "${RED}Error: Either you are not in the office, Cato is disconnected or you need to authenticate to aws${ENDCOLOR}"
      return 1
  fi
}

#########################
# The terraform helpers
#########################
# plan
tfp() {
  op signin # Authenticate first

  local pass_params=()

  while [[ $# -gt 0 ]]; do
    case $1 in
      -s|--skip-template-generation) ;& # fallthrough
      -g|--debug)
        pass_params=("${pass_params[@]}" "$1")
        shift
        ;;
      *)
        break
        ;;
    esac
  done

  __check_connection_to_aws || return $?
  __prepare_terraform_directory "${pass_params[@]}" || return $?

  # Run plan
  terraform plan -parallelism=30 -out plan.out "$@" && terraform show plan.out | sed "s/\(\"Missing purpose - please update a purpose\!\!\!\)/${RED}\1${CLEAR}/" | less -R
}

# apply
tfapply() {
  op signin # Authenticate first
  local pass_params=()

  while [[ $# -gt 0 ]]; do
    case $1 in
      -g|--debug)
        pass_params=("${pass_params[@]}" "$1")
        shift
        ;;
      *)
        echo "Unknown option $1"
        return 1
        ;;
    esac
  done

  terraform apply plan.out
}

# Validate
tfv() {
  local pass_params=()

  while [[ $# -gt 0 ]]; do
    case $1 in
      -s|--skip-template-generation) ;& # fallthrough
      -g|--debug)
        pass_params=("${pass_params[@]}" "$1")
        shift
        ;;
      *)
        echo "Unknown option $1"
        return 1
        ;;
    esac
  done

  __prepare_terraform_directory "${pass_params[@]}" || return $?
  terraform validate
}

# Init
tfi() {
  local pass_params=()

  while [[ $# -gt 0 ]]; do
    case $1 in
      -s|--skip-template-generation) ;& # fallthrough
      -g|--debug)
        pass_params=("${pass_params[@]}" "$1")
        shift
        ;;
      *)
        break
        ;;
    esac
  done

  __check_connection_to_aws || return $?
  __prepare_terraform_directory "${pass_params[@]}" || return $?
  terraform init "$@"
}

# Console
tfc() {
  op signin # Authenticate first
  __prepare_terraform_directory || return $?
  terraform console "$@"
}

# Version updates
tfupdate-provider() {
  local provider="$1"
  local version="$2"

  tfupdate provider "$provider" -v "~> $version" -r .

  # Explanation for the following command:
  # 1. `find` all the version template files
  # 2. On each file run headless nvim with no plugins to update the version
  # 2.1. Edit the file passed from `find`
  # 2.2. Jump to the line containing the provider name
  # 2.3. Jump to word "version" relating to the provider found previously
  # 2.4. Use the `normal` mode, to change the version text in the `"` to the new version
  # 2.5. Save and exit
  find . -name versions.tf.tmpl -exec nvim --headless --noplugin +"e {}" +"/$provider" +"/version" +"normal ci\"~> $version" +'wq' \;
}

__is_semver() {
  [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
}

tfupdate-terraform() {
  local VERSION_FILE="./.terraform-version"
  local GHA_FILE="./.github/workflows/terraform.yml"
  local version="$1"

  if ! __is_semver "$version"; then
    echo "Missing version as first param in structure of X.Y.Z"
    echo
    echo "Usage: tfupdate-terraform <version>"
    return 1
  fi

  # cd into root dir and then cd back
  pushd "$(git rev-parse --show-toplevel)" || return 2

  local old_version=$(< $VERSION_FILE)

  echo "Updating Terraform from $old_version to $version"

  echo "Update $VERSION_FILE"
  echo "$version" > "$VERSION_FILE"

  echo "Update $GHA_FILE"
  sed -i "s/\(terraform_version: \)${old_version}/\1${version}/" "$GHA_FILE"

  echo "Update versions.tf files recursively"
  tfupdate terraform . -r -v "~> $version"

  # Explanation for the following command:
  # 1. `find` all the version template files
  # 2. On each file run headless nvim with no plugins to update the version
  # 2.1. Edit the file passed from `find`
  # 2.2. Replace the terraform version by regex pattern matching
  # 2.3. Save and exit
  find . -name versions.tf.tmpl -exec nvim --headless --noplugin +"e {}" +'%s/\(required_version = "\~> \)'"$old_version"'\("\)/\1'"$version"'\2' +'wq' \;

  popd || return
}


# More helpers
alias tfsummarize="tf-summarize -tree plan.out | less -R"
alias tfsummarize-json="tf-summarize -json plan.out | fx"
alias tfshow="terraform show plan.out | less -R"
alias tfshow-copy="terraform show -no-color plan.out | pbcopy"
alias tf-reset="find ~ -type d -name '.terraform' -exec rm -rf {} +"
