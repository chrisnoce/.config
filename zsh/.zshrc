# History
HISTFILE=${ZDOTDIR}/.zhistory
HISTSIZE=10000
SAVEHIST=10000
bindkey '\e[B' history-search-forward
bindkey '\e[A' history-search-backward

# Options, Environment
setopt autocd
export MYVIMRC='$HOME/.dotfiles/vim/.vimrc'
export VIMINIT='source $MYVIMRC'
export ZPLUG_HOME=${ZDOTDIR}/.zplug
export GNUPGHOME='$HOME/.dotfiles/.gnupg'

# Colors
export TERM='xterm-256color'
autoload -U colors
colors

# Completion
zstyle :compinstall filename '${ZDOTDIR}/.zshrc'
autoload -Uz compinit
compinit

# Library
for script in ${ZDOTDIR}/lib/*; do
    source "$script"
done

# Source Aliases
ALIASDB=${ZDOTDIR}/.zaliases
source $ALIASDB

# ZPLug

    # Check if ZPlug is installed
    if [[ ! -d $ZPLUG_HOME ]]; then
        git clone https://github.com/zplug/zplug $ZPLUG_HOME
        source $ZPLUG_HOME/init.zsh && zplug update
    fi

    # Source ZPlug
    source $ZPLUG_HOME/init.zsh

    # Self-Manage ZPlug
    zplug 'zplug/zplug', hook-build:'zplug --self-manage'

    # Load Plugins
    zplug 'zsh-users/zsh-syntax-highlighting'
    zplug 'denysdovhan/spaceship-prompt'
    zplug 'tarrasch/zsh-autoenv'
    # zplug 'b4b4r07/enhancd', use:init.sh # needs fzy installed (jhawthorn/fzy)
    zplug 'zsh-users/zsh-autosuggestions'

    # Install plugins if there are plugins that have not been installed
    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi

    # Source plugins and add commands to $PATH
    zplug load # --verbose

# End ZPlug

# RBENV
# eval "$(rbenv init -)"
