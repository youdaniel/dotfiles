if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  if [ -d "/proc/acpi/button/lid" ]
  then
    exec ~/.local/bin/wrappedhl
  else
    exec startx
  fi
fi

