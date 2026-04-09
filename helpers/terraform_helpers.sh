#!/usr/bin/env bash

genenrate_terraform_code() {
  find "$(git rev-parse --show-toplevel)/terraform/" -name "*.generated.tf" -delete
  find "$(git rev-parse --show-toplevel)/terraform/" -type d \( -name ".terraform" -o -name ".tf_lint_dir" \) -prune -o -name "*.tf.tmpl" -exec "$(git rev-parse --show-toplevel)/terraform/scripts/genenrate_terraform_code.py" {} \;
}
