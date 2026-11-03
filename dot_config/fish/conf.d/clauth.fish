# clauth: completions + profile shortcuts (fish port of the zshrc setup)
if status is-interactive; and type -q clauth
    clauth completions fish | source

    abbr -a c1 'clauth start 1'
    abbr -a c2 'clauth start 2'
    abbr -a c3 'clauth start 3'
    abbr -a ct 'clauth start team'
end
