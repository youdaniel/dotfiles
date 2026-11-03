if status is-interactive
    function fish_user_key_bindings
        for mode in insert default visual
            bind -M $mode ctrl-space forward-char
        end
    end

    # Vi mode. Set before fzf etc., since changing it rebinds all keys.
    set -g fish_key_bindings fish_vi_key_bindings
    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_replace_one underscore
    set -g fish_cursor_visual block

    # Bundled with fish >= 4.3; matches kitty's Catppuccin Mocha palette
    fish_config theme choose catppuccin-mocha

    if type -q starship
        starship init fish | source
        enable_transience
    end

    if type -q zoxide
        zoxide init fish | source
    end

    if type -q fzf
        fzf --fish | source
        # Keep vi redo on ctrl-r in normal mode; fzf history stays in insert
        bind -M default ctrl-r redo
    end

    if type -q fnm
        fnm env --use-on-cd --shell fish | source
    end

    if type -q nvim
        alias vim nvim
    end

    if type -q exa
        alias ls "exa --color=always --group-directories-first"
        alias la "exa -la --color=always --group-directories-first"
    end

    if type -q bat
        alias cat bat
    end

    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

end
