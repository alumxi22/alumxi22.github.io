#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -euxo pipefail

asdf plugin-add hugo https://github.com/beardix/asdf-hugo.git

# https://github.com/asdf-vm/asdf-nodejs#install
asdf plugin-add nodejs

OTHER_PACKAGES=(
  "yarn"
  "dhall"
  "shellcheck"
  "shfmt"
  "fd"
  "just"
)

for package in "${OTHER_PACKAGES[@]}"; do
  asdf plugin-add "${package}"
done
