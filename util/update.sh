#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function upd_all () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local SELFPATH="$(readlink -m "$BASH_SOURCE"/..)"
  cd "$SELFPATH"/.. || return $?

  echo -n 'Update repo: '
  local REPO_DIR='repo.upstream'
  local REPO_URL='https://github.com/twbs/ratchet'
  [ -f "$REPO_DIR"/.git/config ] \
    || git clone "$REPO_URL" "$REPO_DIR" || return $?
  cd "$REPO_DIR" || return $?
  git pull || return $?
  cd "$SELFPATH"/.. || return $?

  local DIST_ITEMS=(
    css
    fonts
    js
    )
  local ITEM=
  echo -n 'Copy dist/ dirs: '
  for ITEM in "${DIST_ITEMS[@]}"; do
    echo -n "$ITEM… "
    [ ! -e "$ITEM" ] || rm -r -- "$ITEM" || return $?
    cp --target-directory=. --recursive -- "$REPO_DIR/dist/$ITEM" || return $?
  done
  echo 'done.'

  return 0
}













upd_all "$@"; exit $?
