#!/bin/bash

wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz  # download source tarball
tar xfz package-query.tar.gz  # unpack tarball
cd package-query  &&  makepkg -sr  # cd and create package from source
sudo pacman -U package-query*.pkg.tar.xz  # install package - need root privileges

cd ..

wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar xzf yaourt.tar.gz
cd yaourt  &&  makepkg -sr
sudo pacman -U yaourt*.pkg.tar.xz
