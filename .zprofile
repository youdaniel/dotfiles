if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  if [ -d "/proc/acpi/button/lid" ]
  then
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh
    exec ~/.local/bin/wrappedhl
  else
    exec startx
  fi
fi

