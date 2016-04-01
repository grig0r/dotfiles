# .bash_profile

# Get the aliases and functions
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
if [[ $(tty) == /dev/tty1 ]]; then
	exec startx
fi
