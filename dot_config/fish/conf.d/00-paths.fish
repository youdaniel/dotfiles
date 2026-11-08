# Per-machine PATH additions; only directories that exist are set or added
for dir in ~/.local/share/pnpm ~/Library/pnpm
    if test -d $dir
        set -gx PNPM_HOME $dir
        break
    end
end
for dir in /opt/android-sdk ~/Library/Android/sdk
    if test -d $dir
        set -gx ANDROID_HOME $dir
        break
    end
end
# Highest priority first: ~/.local/bin holds the native claude, which must win over
# older copies in package-manager dirs. One fish_add_path call keeps this order (one
# call per dir would prepend each in turn and reverse it). An unset PNPM_HOME or
# ANDROID_HOME drops its entries from the list.
set -l dirs
for dir in ~/.local/bin ~/.cargo/bin ~/go/bin ~/.yarn/bin ~/.bun/bin $PNPM_HOME \
        $ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/platform-tools $ANDROID_HOME/emulator
    test -d $dir; and set -a dirs $dir
end
fish_add_path -g -m $dirs
