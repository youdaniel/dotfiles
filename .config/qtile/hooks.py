import os
import subprocess

from libqtile import hook


@hook.subscribe.startup_once
def start_once():
    subprocess.call([os.path.expanduser("~/.scripts/autostart.sh")])


@hook.subscribe.startup
def start_always():
    subprocess.run(["xsetroot", "-cursor_name", "left_ptr"])
    subprocess.run(["setxkbmap", "-option", "compose:rctrl"])


@hook.subscribe.client_new
def float_firefox(window):
    wm_class = window.window.get_wm_class()
    w_name = window.window.get_name()
    if wm_class == ("Places", "firefox") and w_name == "Library":
        window.floating = True


@hook.subscribe.client_new
def float_steam(window):
    wm_class = window.window.get_wm_class()
    w_name = window.window.get_name()
    if wm_class == ("Steam", "Steam") and (
        w_name != "Steam"
        # w_name == "Friends List"
        # or w_name == "Screenshot Uploader"
        # or w_name.startswith("Steam - News")
        or "PMaxSize" in window.window.get_wm_normal_hints().get("flags", ())
    ):
        window.floating = True
