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
# An unset PNPM_HOME/ANDROID_HOME drops its entries from this list
for dir in ~/.local/bin ~/.cargo/bin ~/go/bin ~/.yarn/bin ~/.bun/bin $PNPM_HOME \
        $ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/platform-tools $ANDROID_HOME/emulator
    test -d $dir; and fish_add_path -g $dir
end
