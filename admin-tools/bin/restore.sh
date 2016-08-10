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

# バックアップファイルが存在しない場合、メッセージを表示し、中断
if [ ! -e "${backup_dir}/${file_name_date}-ldap.tar.gz" ]; then
  echo "${backup_dir}/${file_name_date}-ldap.tar.gz ファイルが存在しません"
fi
if [ ! -e "${backup_dir}/${file_name_date}-portal.tar.gz" ]; then
  echo "${backup_dir}/${file_name_date}-portal.tar.gz ファイルが存在しません"
fi

# すでに解凍先のディレクトリがある場合、メッセージを表示し、中断
if [ -e "$script_dir/../../ldap/data" ]; then
  echo "解凍先ディレクトリが存在します。 $script_dir/../../ldap/data"
fi
if [ -e "$script_dir/../../project/data" ]; then
  echo "解凍先ディレクトリが存在します。 $script_dir/../../project/data"
fi

tar zxvf "${backup_dir}/${file_name_date}-ldap.tar.gz" -C "$script_dir/../../ldap" data
tar zxvf "${backup_dir}/${file_name_date}-portal.tar.gz" -C "$script_dir/../../project" data
