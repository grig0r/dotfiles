#completions
fpath=(/home/grig0r/.zsh/completion $fpath)  #custom cumpletions
autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' menu select
# zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'   #smartcase
# zstyle ':completion:*' matcher-list 'r:[[:ascii:]]||[[:ascii:]]=** r:|=* m:{a-z\-}={A-Z\_}'

# fzf
. /usr/share/fzf/key-bindings.zsh
. /etc/profile.d/fzf-extras.zsh


#correction
# setopt correctall

#prompt style
autoload -U colors && colors
autoload -U promptinit && promptinit
PS1="%{$fg[red]%}%n\
%{$reset_color%}@\
%{$fg[blue]%}%m \
%{$reset_color%}in \
%{$fg_bold[yellow]%}%~
%{$fg_bold[yellow]%}> %{$reset_color%}"
# RPROMPT="[%{$fg_no_bold[yellow]%}ruham psa jak sra%{$reset_color%}]"

#history settings
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

#misc settings
setopt autocd
bindkey -v  # vi mode

#syntax highlighting
source /home/grig0r/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#ls highlighting
eval `dircolors`
alias ls="ls -h --color=auto"
alias grep="grep --color"

# base 16
BASE16_SHELL="$HOME/.config/base16-shell/base16-marrakesh.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

#aliases
# alias c="clear"
# alias r="ranger"
# alias v="nvim"
alias S="sudo poweroff"
alias R="sudo reboot"
alias s="sudo pm-suspend"
alias H="sudo pm-hibernate"
# alias cdP="cd /etc/portage"
alias trc="transmission-remote-cli"
alias tr="transmission-remote 127.0.0.1:9091"
alias mp="ncmpcpp"
# alias B="acpitool"
# alias n="nmtui"
# alias m="sudo /home/grig0r/mount"
alias win="sudo mount /dev/sda3 /mnt/win"
alias du="du -h"
alias dirs="dirs -v"
alias pd="pushd"
alias hc="herbstclient"
alias hcfhd="hc set_monitors 1364x768+0+0 1920x1080+1364+0"
alias song="youtube-dl -x --audio-format best --exec 'mv {} ~/Music/yt && mpc update && sleep 2 && mpc add yt/{}' "$1""
# alias pdf="~/dev/rst2pdf"
# 
#export MPD_HOST=/home/grig0r/.mpd/socket

