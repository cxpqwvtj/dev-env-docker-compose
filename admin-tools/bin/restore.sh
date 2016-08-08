#!/bin/bash

if [ $# -lt 1 ]; then
  echo "バックアップファイルのファイル名(日時)を指定してください"
  exit 0
fi

abs_dirname() {
  local cwd="$(pwd)"
  local path="$1"

  while [ -n "$path" ]; do
    cd "${path%/*}"
    local name="${path##*/}"
    path="$(readlink "$name" || true)"
  done

  pwd -P
  cd "$cwd"
}

script_dir="$(abs_dirname "$0")"
file_name_date="`date '+%Y%m%d%H%M%S'`"
backup_dir="${script_dir}/../../backup"

if [ ! -e "${backup_dir}" ]; then
  echo "create backup dir"
  mkdir -p "${backup_dir}"
fi

# TODO:すでに解凍先のディレクトリがある場合、メッセージを表示し、中断
# TODO:バックアップファイルが存在しない場合、メッセージを表示し、中断

tar zxvf "${backup_dir}/${file_name_date}-ldap.tar.gz" -C "$script_dir/../../ldap" data
tar zxvf "${backup_dir}/${file_name_date}-portal.tar.gz" -C "$script_dir/../../project" data
