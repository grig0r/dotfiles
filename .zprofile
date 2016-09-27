# .bash_profile

# Get the aliases and functions
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less
if [[ $(pgrep devmon) ]]; then
	# xd
else
	exec devmon 2>&1 > /dev/null &!
fi
# exec pulseaudio --start &
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
if [[ $(tty) == /dev/tty1 ]]; then
	exec startx
fi
# eval `keychain --eval id_ed25519`
