# Per-machine PATH additions; only directories that exist are added
for dir in ~/.local/bin ~/.cargo/bin /opt/android-sdk/cmdline-tools/latest/bin
    test -d $dir; and fish_add_path -g $dir
end
