#!/usr/bin/env bash

set -u

# Este script SOMENTE baixa arquivos de um remote (nuvem) para uma pasta LOCAL.
# Ele NUNCA envia ou modifica arquivos no remote/nuvem — o remote é sempre a
# origem (source) e o local é sempre o destino (dest) no rclone sync.

REMOTE_DIR="${1:-}"
LOCAL_DIR="${2:-}"

# Verifica dependências
for cmd in rclone notify-send; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Erro: comando '$cmd' não encontrado no PATH." >&2
    exit 1
  fi
done

if [ -z "$REMOTE_DIR" ] || [ -z "$LOCAL_DIR" ]; then
  notify-send -u critical -i dialog-error "Rclone" "Uso: $(basename "$0") <remote:diretorio> <pasta_local>"
  echo "Uso: $0 <remote:diretorio> <pasta_local>"
  echo "Este script apenas BAIXA da nuvem para o local. A nuvem nunca é alterada."
  exit 1
fi

# Trava de segurança: o destino precisa ser um caminho local, não um remote.
# Remotes do rclone sempre têm o formato "nome:caminho" (contêm ':').
# Se o segundo argumento contiver ':', provavelmente é um remote sendo usado
# por engano como destino — abortamos para nunca escrever na nuvem.
if [[ "$LOCAL_DIR" == *:* ]]; then
  echo "Erro: o destino '$LOCAL_DIR' parece ser um remote do rclone (contém ':')." >&2
  echo "Este script só baixa de um remote para uma pasta local — nunca o contrário." >&2
  notify-send -u critical -i dialog-error "Rclone" "Destino inválido: '$LOCAL_DIR' parece ser um remote."
  exit 1
fi

mkdir -p "$LOCAL_DIR"

EXIT_CODE=0

notify-send -u normal -i folder-sync "Rclone" "Verificando alterações em ${REMOTE_DIR}..."

# rclone check apenas COMPARA os dois lados, sem modificar nada em nenhum dos
# dois. Usamos --one-way para ignorar arquivos que existem só no local (assim
# arquivos locais extras não geram "diferença" nem disparam sync desnecessário).
if rclone check "$REMOTE_DIR" "$LOCAL_DIR" --one-way >/dev/null 2>&1; then
  notify-send -u low -i dialog-ok "Rclone" "Nenhuma alteração detectada em ${REMOTE_DIR}."
  echo "Nenhuma alteração detectada entre ${REMOTE_DIR} e ${LOCAL_DIR}."
else
  notify-send -u normal -i folder-sync "Rclone" "Alterações detectadas. Baixando de ${REMOTE_DIR} para ${LOCAL_DIR}..."

  # rclone sync <origem> <destino>: o destino (LOCAL_DIR) é atualizado para
  # espelhar a origem (REMOTE_DIR). A origem nunca é escrita — por isso é
  # essencial que REMOTE_DIR seja sempre o primeiro argumento.
  if rclone sync -P "$REMOTE_DIR" "$LOCAL_DIR"; then
    notify-send -u low -i dialog-ok "Rclone" "Download concluído: ${REMOTE_DIR} -> ${LOCAL_DIR}"
    echo
    echo "Download concluído com sucesso."
  else
    notify-send -u critical -i dialog-error "Rclone" "Falha no download: ${REMOTE_DIR} -> ${LOCAL_DIR}"
    echo
    echo "Falha no download."
    EXIT_CODE=1
  fi
fi

# Só espera Enter se estiver rodando em um terminal interativo
if [ -t 0 ]; then
  read -r -p "Pressione Enter para fechar..."
fi

exit "$EXIT_CODE"
