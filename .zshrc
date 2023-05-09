fpath=(~/.zsh $fpath)

# setup homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# add toolbox binaries to path
if [ -d "$HOME/.toolbox" ]; then
  export PATH="$HOME/.toolbox/bin:$PATH"
fi

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
  zgenom load zsh-users/zsh-completions
  zgenom load zdharma-continuum/fast-syntax-highlighting

  zgenom load rupa/z
  zgenom load darvid/zsh-poetry
  zgenom load jeffreytse/zsh-vi-mode

  zgenom save

  zgenom compile "$HOME/.zshrc"
fi

# NVIM as default editor
if command -v nvim &> /dev/null
then
    export EDITOR=nvim
    export GIT_EDITOR=nvim
    export VISUAL=nvim
fi

export BAT_THEME="Catppuccin-mocha"

# vim keybindings
bindkey -v

# binding for zsh autosuggestions
bindkey '^ ' autosuggest-accept

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
