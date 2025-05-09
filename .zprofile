export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
