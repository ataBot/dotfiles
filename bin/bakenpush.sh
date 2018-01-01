#!/usr/bin/env bash

# This command indicates if we have any local commits
# waiting to be pushed:
#
#     git log --oneline FETCH_HEAD..HEAD
#
# This one indicates any commits in remote waiting to
# be pulled:
#
#      git log --oneline HEAD..FETCH_HEAD


set -e

WORK_DIR=$1
CURR_DIR=$(pwd)
QUIET_PERIOD=$2

cd $WORK_DIR

flashbake -q . $QUIET_PERIOD

if [[ $(git log --oneline FETCH_HEAD..HEAD) ]]; then
    git fetch -q
    if [[ $(git log --oneline HEAD..FETCH_HEAD) ]]; then
        git rebase -q
    fi
    git push -q
else
    git pull -q
fi

cd $CURR_DIR
