# vim: set ts=4 sw=4 sts=0 et ft=sh fenc=utf-8 ff=unix :

# workaround for "zsh compinit: insecure directories"
alias compinit='compinit -u'
autoload -Uz compinit && compinit
autoload -Uz zmv

setopt auto_list
setopt auto_menu
setopt auto_cd

zstyle ':completion:*:default' menu select=1

export LANG=ja_JP.UTF-8
export LC_TIME=C

# HOMEBREW
# See also: https://github.com/drduh/macOS-Security-and-Privacy-Guide/issues/138
if [ -x "$HOME/homebrew/bin/brew" ]; then
  brewInstalled=yes
  export HOMEBREW_PREFIX="$HOME/homebrew"
elif [ -x "$HOME/usr/local/bin/brew" ]; then
  brewInstalled=yes
  export HOMEBREW_PREFIX="$HOME/usr/local"
elif [ -x /usr/local/bin/brew ]; then
  brewInstalled=yes
  export HOMEBREW_PREFIX="/usr/local"
elif [ -x /opt/homebrew/bin/brew ]; then
  brewInstalled=yes
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  brewInstalled=no
  export HOMEBREW_PREFIX=/nowhere
fi

if [ "$brewInstalled" = yes ]; then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_INSECURE_REDIRECT=1
  #export HOMEBREW_CASK_OPTS="--require-sha --appdir=/Applications --no-quarantine"
  export HOMEBREW_CASK_OPTS="--appdir=/Applications --no-quarantine"
fi

if [ -d "${HOMEBREW_PREFIX}/opt/zplug" ]; then
  zplugInstalled=yes
  export ZPLUG_HOME="${HOMEBREW_PREFIX}/opt/zplug"
fi

# Command search pathes
setopt +o nomatch
cat "${HOME}/.zshrc.d/paths" /etc/paths.d/* /etc/paths 2>/dev/null \
  | grep -v ^# \
  | awk NF \
  | while read -r CMDPATH; do
    if [ -d "$(eval echo "$CMDPATH")" ]; then
      if [ -z "$CPATH" ]; then
        CPATH="$(eval echo "$CMDPATH")"
      else
        CPATH="$CPATH":"$(eval echo "$CMDPATH")"
      fi
    fi
  done
setopt -o nomatch
export PATH="$CPATH"
typeset -gU PATH

if [ -f "$HOME/.zsh/git-completion.zsh" ] && [ "$(command -v git)" ]; then
  zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.zsh
  fpath=(~/.zsh $fpath)
  autoload -Uz compinit && compinit
fi

if [ -d "${HOMEBREW_PREFIX}/site-functions" ]; then
  fpath=("${HOMEBREW_PREFIX}/site-functions" $fpath)
  autoload -Uz compinit && compinit
fi

if command -v gh >/dev/null 2>&1; then
  eval "$(gh completion -s zsh)"
fi

# Additional rcs
for zrc in "${HOME}/.zshrc.d/aliases" \
  "${HOME}/.zshrc.d/homebrew.sh" \
  "${HOME}/.zshrc.d/multipass" \
  "${HOME}/.zshrc.d/nodejs" \
  "${HOME}/.zshrc.d/aliases_by_host" \
  "${HOME}/.zshrc.d/zshrc_by_host" \
  "${ZPLUG_HOME}/init.zsh"; do
  if [ -f "$zrc" ]; then . "$zrc"; fi
done

if [ "${zplugInstalled:-no}" = yes ]; then
  zplug "modules/history", from:prezto
  zplug "modules/directory", from:prezto
  if [ "$(uname -s)" = Darwin ]; then
    zplug "modules/osx", from:prezto
  fi

  if ! zplug check --verbose; then zplug install; fi
  zplug load
else
  # History
  # https://zsh.sourceforge.io/Doc/Release/Options.html#History
  setopt share_history
  setopt inc_append_history
  setopt hist_ignore_dups
  setopt hist_ignore_space
fi

# History
# https://qiita.com/takc923/items/8409a76e8a660f9f329f
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000

# Prompt
export PS1="%n@%m:%2~[%h]%# "

# color設定
# http://neko-mac.blogspot.com/2015/03/mac_18.html
export LSCOLORS=DxGxcxdxBxegedabagacad
zstyle ':completion:*' list-colors di=33 ln=36 ex=31
zstyle ':completion:*:kill:*' list-colors \
  '=(#b) #([0-9]#)*( *[a-z])*=34=31=33'

# 一覧表示の形式設定
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

# AWS
if [ -f "${HOME}/.aws/config" ] && [ -z "$AWS_CONFIG_FILE" ]; then
  export AWS_CONFIG_FILE="${HOME}/.aws/config"
fi

if [ -f "${HOME}/.aws/credentials" ] && [ -z "$AWS_SHARED_CREDENTIALS_FILE" ]; then
  export AWS_SHARED_CREDENTIALS_FILE="${HOME}/.aws/credentials"
fi

# xmllint
export XMLLINT_INDENT="    "
