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
  if [ "$(file_age_hours repo.upstream/.git/FETCH_HEAD)" -le 1 ]; then
    echo 'skip: fresh enough'
  else
    cd "$REPO_DIR" || return $?
    git pull || return $?
    cd "$SELFPATH"/.. || return $?
  fi

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

  echo -n 'Compare versions: '
  local VER_SED='s~^\s*"version":\s*"(\S+)",?$~\1~p'
  local RAT_VER="$(sed -nre "$VER_SED" -- "$REPO_DIR"/package.json)"
  local PKG_VER="$(sed -nre "$VER_SED" -- package.json)"
  case "$PKG_VER" in
    "$RAT_VER"[0-9][0-9][0-9] )
      echo "ok, release ${PKG_VER#$RAT_VER}";;
    * )
      echo "E: this package's version ($PKG_VER)" \
        "doesn't seem to match ratchet's ($RAT_VER)!" >&2
      return 3;;
  esac

  return 0
}


function file_age_hours () {
  perl -e "print int ((-M @ARGV[0]) * 24)" -- "$@"
}













upd_all "$@"; exit $?
