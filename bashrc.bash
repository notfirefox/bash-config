# .bashrc
# shellcheck shell=bash
# shellcheck disable=SC1091

# source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# enable colors on macos
if [[ "$OSTYPE" == darwin* ]]; then
    export CLICOLOR=1
fi

# set environment variables
export EDITOR=ed
export VISUAL=vi

# user specific environment
if ! [[ "$PATH" == *"$HOME/.local/bin:$HOME/bin:"* ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# custom prompt
PS1='[\u@\h \W]\$ '

# set homebrew prefix
if [[ "$OSTYPE" == darwin* ]]; then
    case "$(uname -m)" in
    x86*) HOMEBREW_PREFIX="/usr/local" ;;
    arm*) HOMEBREW_PREFIX="/opt/homebrew" ;;
    esac
fi

# homebrew and bash completion
if [[ -f "$HOMEBREW_PREFIX/bin/brew" ]]; then
    eval "$("$HOMEBREW_PREFIX"/bin/brew shellenv)"
    if [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
        . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
    fi
fi
