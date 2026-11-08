# Hand interactive zsh sessions over to fish. Source this from ~/.zshrc; fish sets up its
# own environment (conf.d). Scripts, `zsh -c` and `zsh -i -c` stay
# in zsh, as does zsh started from fish. Skip with: NO_FISH=1 zsh
() {
  [[ -o interactive && -z $ZSH_EXECUTION_STRING && -z $NO_FISH ]] || return 0
  [[ ${$(ps -o comm= -p $PPID):t} == fish ]] && return 0
  local fish
  for fish in /opt/homebrew/bin/fish /usr/local/bin/fish /usr/bin/fish; do
    [[ -x $fish ]] && exec $fish
  done
}
