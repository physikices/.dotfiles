#!/usr/bin/env bash

# Script para limpar pacotes órfãos e cache no Arch Linux (pacman + paru)

echo ">>> Limpando pacotes órfãos..."
sudo pacman -Rns $(pacman -Qdtq) --noconfirm 2>/dev/null || echo "Nenhum órfão encontrado."

echo ">>> Limpando cache do pacman (mantendo 2 versões)..."
sudo paccache -r -k2

echo ">>> Limpando cache completo do pacman..."
sudo pacman -Sc --noconfirm

echo ">>> Limpando pacotes órfãos do AUR (paru)..."
paru -Qdtq | paru -Rns --noconfirm -

echo ">>> Limpando cache do paru..."
paru -Sc --noconfirm

echo ">>> Limpando diretório de cache do paru manualmente..."
rm -rf ~/.cache/paru/clone/*

echo ">>> Finalizado!"
