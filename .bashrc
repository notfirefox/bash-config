# .bashrc
# shellcheck shell=bash
# shellcheck disable=SC1091

# set environment variables
export EDITOR=ed
export VISUAL=vi

# configure history
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth

# set bash options
shopt -s histappend

# custom prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# set the title for xterm to user@host:dir
if [[ "$TERM" == rxvt* || "$TERM" == xterm* ]]; then
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
fi

# handle macos specific stuff
if [[ "$OSTYPE" == darwin* ]]; then
    # enable colors for cli applications
    export CLICOLOR=1

    # figure out homebrew prefix
    case "$(uname -m)" in
    x86*) HOMEBREW_PREFIX="/usr/local" ;;
    arm*) HOMEBREW_PREFIX="/opt/homebrew" ;;
    esac

    # configure shell environment for homebrew
    if [[ -f "$HOMEBREW_PREFIX/bin/brew" ]]; then
        eval "$("$HOMEBREW_PREFIX"/bin/brew shellenv)"
    fi
elif [[ "$OSTYPE" == linux* ]]; then
    # set ls colors using dircolors
    if [[ -x /usr/bin/dircolors ]]; then
        eval "$(dircolors -b)"
    fi

    # enable colors for cli applications
    alias diff='diff --color=auto'
    alias grep='grep --color=auto'
    alias ls='ls --color=auto'
fi

# add haskell to path
if [[ -r "$HOME/.ghcup/env" ]]; then
    . "$HOME/.ghcup/env"
fi

# add users dirs to path
if [[ "$PATH" != *"$HOME/.local/bin:$HOME/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# enable programmable completion features
if [[ -r "${HOMEBREW_PREFIX:-}/etc/profile.d/bash_completion.sh" ]]; then
    . "${HOMEBREW_PREFIX:-}/etc/profile.d/bash_completion.sh"
fi
