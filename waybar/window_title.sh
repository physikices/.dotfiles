#!/usr/bin/env bash

title=$(hyprctl activewindow -j | jq -r '.title')

if [ "$title" = "null" ] || [ -z "$title" ]; then
  # Nenhuma janela ativa → módulo vazio
  echo '{"text": "", "class": "empty"}'
else
  # Janela ativa → exibe o título
  echo "{\"text\": \"<span color='#fab387'>${title}</span>\", \"class\": \"active\"}"
  # echo "{\"text\": \"$window_title\", \"class\": \"active\"}"
fi

