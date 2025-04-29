#!/bin/bash

DOTFILES_DIR=~/dotfiles_macos
BACKUP_DIR=~/dotfiles_backup
FILES=(.bash_profile .bashrc .skhdrc .yabairc .vimrc .vim .config)

mkdir -p $BACKUP_DIR

for file in "${FILES[@]}"; do
  if [ -e ~/$file ] && [ ! -L ~/$file ]; then
    mv ~/$file $BACKUP_DIR/
  fi
  ln -sf $DOTFILES_DIR/$file ~/$file
done

echo "Dotfiles symlinked. Original files moved to $BACKUP_DIR."
