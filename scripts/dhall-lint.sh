#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -eu pipefail

DHALL_FILES=()

mapfile -t DHALL_FILES < <(fd --extension dhall)

function lint() {
  local file="$1"

  local LINT_ARGS=(
    "lint"
    "--inplace"
    "${file}"
  )

  if [ "${CHECK:-"false"}" == "true" ]; then
    LINT_ARGS+=("--check")
  fi

  result=$(dhall "${LINT_ARGS[@]}" 2>&1)
  rc=$?

  if [ -n "$result" ]; then
    echo "${file}:"
    echo "$result"
    echo
  fi

  exit "$rc"
}
export -f lint

# echo 'will cite' | parallel --citation &>/dev/null

./scripts/parallel_run.sh lint {} ::: "${DHALL_FILES[@]}"
