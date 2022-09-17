fpath=(~/.zsh $fpath)

# add cargo binaries to path
if [ -d "$HOME/.cargo" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# add poetry binaries to path
if [ -d "$HOME/.poetry" ]; then
  export PATH="$HOME/.poetry/bin:$PATH"
fi

# add yarn binaries to path
if [ -d "$HOME/.yarn" ]; then
  export PATH="$HOME/.yarn/bin:$PATH"
fi

export CLASSPATH=".:/usr/share/java/:/usr/share/java/junit.jar:/usr/share/java/hamcrest-core.jar"

# Load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

zgenom autoupdate

if ! zgenom saved; then
  echo "Creating a zgenom save"

  zgenom ohmyzsh

  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/command-not-found
  zgenom ohmyzsh plugins/docker

  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-syntax-highlighting
  zgenom load zsh-users/zsh-completions

  zgenom load rupa/z
  zgenom load darvid/zsh-poetry
  zgenom load softmoth/zsh-vim-mode

  zgenom save

  zgenom compile "$HOME/.zshrc"
fi

# NVIM as default editor
if command -v lvim &> /dev/null
then
    export EDITOR=lvim
    export GIT_EDITOR=lvim
    export VISUAL=lvim
    export MANPAGER="$EDITOR -c +Man!"
fi

export BAT_THEME="Dracula"

# vim keybindings
bindkey -v

# binding for zsh autosuggestions
bindkey '^ ' autosuggest-accept

# Fast node manager
eval "$(fnm env)"

# Load aliases
[[ -f ~/.aliases ]] && . ~/.aliases

# Newline
function precmd() {
  # Print a newline before the prompt, unless it's the
  # first prompt in the process.
  if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
    NEW_LINE_BEFORE_PROMPT=1
  elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
    echo ""
  fi
}

# starship prompt
eval "$(starship init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/.miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
