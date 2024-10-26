#!/usr/bin/with-contenv bash

set -eu
set -o pipefail


GROUP_NAME='time-machine-users'

if ! getent group "$GROUP_NAME" > /dev/null 2>&1; then
  groupadd --non-unique --gid "$PGID" "$GROUP_NAME"
fi

if ! id -u "$SMB_USER" > /dev/null 2>&1; then
  useradd --system --non-unique --gid "$GROUP_NAME" --uid "$PUID" "$SMB_USER"
fi


printf '%s\n%s\n' "$SMB_PASSWORD" "$SMB_PASSWORD" | smbpasswd -s -a "$SMB_USER"


chown "$SMB_USER":"$GROUP_NAME" '/share'
