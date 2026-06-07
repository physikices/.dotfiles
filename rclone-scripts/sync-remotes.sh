#!/usr/bin/env bash

set -u

FROM_HERE="${1:-}"
TO_THERE="${2:-}"

if [ -z "$FROM_HERE" ] || [ -z "$TO_THERE" ]; then
  notify-send -u critical -i dialog-error "Rclone" "Uso: sync-remote.sh
  <from_here:> <to_there>"
  echo "Uso: $0 <from_here:> <to_there>"
  exit 1
fi

notify-send -u normal -i folder-sync "Rclone" "Iniciando sincronizacao de
${FROM_HERE} para ${TO_THERE}"

mkdir -p "$HOME/.servers/$TO_THERE"

if rclone sync -P "$FROM_HERE" "$TO_THERE"; then
  notify-send -u low -i dialog-ok "Rclone" "Sincronizacao concluida:
  ${FROM_HERE} success!"
  echo
  echo "Sincronizacao concluida com sucesso."
else
  notify-send -u critical -i dialog-error "Rclone" "Falha na sincronizacao:
  ${FROM_HERE}"
  echo
  echo "Falha na sincronizacao."
fi

read -r -p "Pressione Enter para fechar..."
