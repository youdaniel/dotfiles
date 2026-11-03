# Put Homebrew on PATH (macOS / Linuxbrew); no-op where brew isn't installed
for brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew
    if test -x $brew
        $brew shellenv fish | source
        break
    end
end
