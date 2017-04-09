# for zsh

export EDITOR="vim"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
#export TODOTXT_DEFAULT_ACTION=ls
#alias t='todo-txt'

export PATH=/usr/local/bin:$PATH

export JAVA_HOME=/usr/local/jdk1.8.0.121

export CHEATCOLORS=true

#Set tmux 256 color and start tmux
[ -z "$TMUX" ] && export TERM=xterm-256color && tmux -2 new

#Use vi style
#bindkey -v
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
