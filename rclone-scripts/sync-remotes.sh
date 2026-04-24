#!/usr/bin/env bash

set -u

REMOTE="${1:-}"
DESTINO="${2:-}"

if [ -z "$REMOTE" ] || [ -z "$DESTINO" ]; then
  notify-send -u critical -i dialog-error "Rclone" "Uso: sync-remote.sh
  <remote:> <destino>"
  echo "Uso: $0 <remote:> <destino>"
  exit 1
fi

notify-send -u normal -i folder-sync "Rclone" "Iniciando sincronizacao de
${REMOTE} para ${DESTINO}"

mkdir -p "$DESTINO"

if rclone sync -P "$REMOTE" "$DESTINO"; then
  notify-send -u low -i dialog-ok "Rclone" "Sincronizacao concluida:
  ${REMOTE} success!"
  echo
  echo "Sincronizacao concluida com sucesso."
else
  notify-send -u critical -i dialog-error "Rclone" "Falha na sincronizacao:
  ${REMOTE}"
  echo
  echo "Falha na sincronizacao."
fi

read -r -p "Pressione Enter para fechar..."
