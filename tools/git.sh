#!/usr/bin/env bash

if [ "$(id -u)" == "0" ]; then
   echo "This script can't be run as root. root permissions will be asked if required ;)" 1>&2
   exit 1
fi

ARGUMENT_LIST=(
    "git-user"
    "git-email"
)

# read arguments
opts=$(getopt \
    --longoptions "$(printf "%s:," "${ARGUMENT_LIST[@]}")" \
    --name "$(basename "$0")" \
    --options "" \
    -- "$@"
)

eval set --$opts

git_email=""
git_user=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --git-email)
      git_email=$2
      shift 2
      ;;
    --git-user)
      git_user=$2
      shift 2
      ;;
    *)
      break
      ;;
  esac
done

sudo apt install -y -qq git-core

git --version

if [ "$git_user" != "" ]; then
  git config --global user.name "$git_user"
fi

if [ "$git_email" != "" ]; then
  git config --global user.email "$git_email"
fi
