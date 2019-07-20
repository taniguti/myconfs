autoload -Uz compinit && compinit

setopt auto_list
setopt auto_menu
setopt auto_cd

zstyle ':completion:*:default' menu select=1

export LANG=ja_JP.UTF-8

# History
HISTFILE="$HOME/.zsh-history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt share_history

# Command aliases
if [ "$HOME/.zsh_aliases" ]; then . "$HOME/.zsh_aliases" ; fi

# Show system info
if [ "$HOME/.systeminfo" ]; then . "$HOME/.systeminfo" ; fi
