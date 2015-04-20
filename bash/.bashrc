# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# save multiline commands on one line, using semi-colons where needed
shopt -s cmdhist

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=-1
HISTFILESIZE=-1
HISTTIMEFORMAT='%F %T'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w $(__git_ps1 " (%s)") \$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHEDSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"

export PROMPT_COMMAND=_prompt_command
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ENV=$HOME/.bashrc
export EDITOR=emacsclient
export FCEDIT=$EDITOR
export GZIP='--name'

umask 002

_prompt_command ()
{
  local status="$?"
  if [ $status != 0 ]; then
    echo "exited with $status" 1>&2
  fi

  # share bash history among all running bash shells as commands are entered
 history -a && history -n
}

if [ -f ~/bin/git-prompt.sh ] ; then
    source ~/bin/git-prompt.sh
fi
