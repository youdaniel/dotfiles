import os
import subprocess

from libqtile import hook, qtile


@hook.subscribe.startup_once
def start_once():
    subprocess.call([os.path.expanduser("~/.local/bin/autostart.sh")])


@hook.subscribe.startup
def start_always():
    subprocess.run(["xsetroot", "-cursor_name", "left_ptr"])
    subprocess.run(["setxkbmap", "-option", "compose:rctrl"])


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


@hook.subscribe.layout_change
def layout_change(layout, group):
    bar = qtile.current_screen.top
    bar.show(False) if qtile.current_layout.info()["name"] == "max" else bar.show(True)
