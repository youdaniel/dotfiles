import os
import subprocess

from libqtile import hook


@hook.subscribe.startup_once
def start_once():
    subprocess.call([os.path.expanduser("~/.scripts/autostart.sh")])


@hook.subscribe.startup
def start_always():
    subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])
