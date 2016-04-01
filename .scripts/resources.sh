#!/bin/bash

#VIM
VIMDIR=~/.vim
if [[ ! -d $VIMDIR ]]; then
	mkdir $VIMDIR
	echo "created $VIMDIR"
else 
	echo "$VIMDIR already existing"
fi
if [[ ! -d $VIMDIR/colors ]]; then
	mkdir $VIMDIR/colors
fi
git clone git://github.com/chriskempson/base16-vim.git $VIMDIR/colors/base16
cp $VIMDIR/colors/base16/colors/*.vim $VIMDIR/colors/

if [[ ! -d $VIMDIR/autoload ]]; then
	mkdir $VIMDIR/autoload
fi
git clone https://github.com/junegunn/vim-plug/ $VIMDIR/autoload/plug
cp $VIMDIR/autoload/plug/plug.vim $VIMDIR/autoload
rm -rf $VIMDIR/autoload/plug

#ZSH

if [[ ! -d ~/.zsh ]]; then
	mkdir ~/.zsh
fi
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
