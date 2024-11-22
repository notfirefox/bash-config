# .bashrc
# shellcheck shell=bash
# shellcheck disable=SC1091

# source global definitions
if [[ -f /etc/bashrc ]]; then
    . /etc/bashrc
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

    # use bash completion from homebrew
    if [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
        . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
    fi
fi
