# .bashrc
# shellcheck shell=bash
# shellcheck disable=SC1091

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
elif [[ "$OSTYPE" == linux* ]]; then
    # enable color support of ls and also add handy aliases
    if [[ -x /usr/bin/dircolors ]]; then
        eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias diff='diff --color=auto'
        alias grep='grep --color=auto'
        alias zgrep='zgrep --color=auto'
        alias xzgrep='xzgrep --color=auto'
    fi
fi

# enable programmable completion features
if [[ -r "${HOMEBREW_PREFIX:-}/etc/profile.d/bash_completion.sh" ]]; then
    . "${HOMEBREW_PREFIX:-}/etc/profile.d/bash_completion.sh"
fi
