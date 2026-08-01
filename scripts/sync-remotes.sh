#!/usr/bin/env bash

set -u

FROM_HERE="${1:-}"
TO_THERE="${2:-}"

# Verifica dependências
for cmd in rclone notify-send; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Erro: comando '$cmd' não encontrado no PATH." >&2
    exit 1
  fi
done

if [ -z "$FROM_HERE" ] || [ -z "$TO_THERE" ]; then
  notify-send -u critical -i dialog-error "Rclone" "Uso: $(basename "$0") <from_here> <to_there>"
  echo "Uso: $0 <from_here:> <to_there>"
  exit 1
fi

notify-send -u normal -i folder-sync "Rclone" "Iniciando sincronizacao de ${FROM_HERE} para ${TO_THERE}"

EXIT_CODE=0

if rclone sync -P "$FROM_HERE" "$TO_THERE"; then
  notify-send -u low -i dialog-ok "Rclone" "Sincronizacao concluida: ${FROM_HERE} -> ${TO_THERE}"
  echo
  echo "Sincronizacao concluida com sucesso."
else
  notify-send -u critical -i dialog-error "Rclone" "Falha na sincronizacao: ${FROM_HERE} -> ${TO_THERE}"
  echo
  echo "Falha na sincronizacao."
  EXIT_CODE=1
fi

# Só espera Enter se estiver rodando em um terminal interativo
if [ -t 0 ]; then
  read -r -p "Pressione Enter para fechar..."
fi

exit "$EXIT_CODE"
