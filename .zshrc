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

export BAT_THEME="Catppuccin Mocha"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# vim keybindings
bindkey -v

# binding for zsh autosuggestions
bindkey '^ ' autosuggest-accept

# Fast node manager
eval "$(fnm env)"

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# zoxide
eval "$(zoxide init zsh)"

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

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE='/usr/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/daniel/.micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
#
# pnpm
export PNPM_HOME="/home/daniel/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
