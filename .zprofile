export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  if [ -d "/proc/acpi/button/lid" ]
  then
    exec ~/.local/bin/wrappedhl
  else
    exec startx
  fi
fi

