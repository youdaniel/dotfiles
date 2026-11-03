if status is-interactive
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

    function fish_user_key_bindings
        for mode in insert default visual
            bind -M $mode ctrl-space forward-char
        end
    end
end
