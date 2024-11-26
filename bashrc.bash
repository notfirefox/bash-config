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

    # use bash completion from homebrew
    if [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
        . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
    fi
elif [[ "$OSTYPE" == linux* ]]; then
    # enable color support of ls and also add handy aliases
    if [[ -x /usr/bin/dircolors ]]; then
        eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        alias zgrep='zgrep --color=auto'
        alias xzgrep='xzgrep --color=auto'
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
fi
