# Environment for every fish, including ones kitty starts without a zsh parent
if type -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx GIT_EDITOR nvim
end

if type -q bat
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -gx MANROFFOPT -c
end
