# add cargo to path
if [ -d "/home/daniel/.cargo" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# add poetry to path
if [ -d "/home/daniel/.poetry" ]; then
  export PATH="$HOME/.poetry/bin:$PATH"
fi

# add yarn to path
if [ -d "/home/daniel/.yarn" ]; then
  export PATH="$HOME/.yarn/bin:$PATH"
fi

# Load Antigen
source $HOME/antigen.zsh

# Load Antigen configuration
antigen init $HOME/.antigenrc

# ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;      
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# NVIM as default editor
if command -v nvim &> /dev/null
then
    export EDITOR=nvim
    export GIT_EDITOR=nvim
    export VISUAL=nvim
    export MANPAGER="nvim +Man!"
fi

# FZF
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!{node_modules,.git}'"

export BAT_THEME="Dracula"
# export COLORTERM="truecolor"

# vim keybindings
bindkey -v

# binding for zsh autosuggestions
bindkey '^ ' autosuggest-accept

# Speed up compinit
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Fast node manager
eval "$(fnm env)"

# Load aliases
[[ -f ~/.aliases ]] && . ~/.aliases

# Newline
precmd() {
  precmd() {
    echo
  }
}

# starship prompt
eval "$(starship init zsh)"
