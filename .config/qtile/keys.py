import os

from libqtile.config import EzClick as Click
from libqtile.config import EzDrag as Drag
from libqtile.config import EzKey as Key
from libqtile.lazy import lazy

SCRIPTS = os.path.expanduser("~/.config/qtile/scripts")


def float_to_front():
    @lazy.function
    def __inner(qtile):
        for group in qtile.groups:
            for window in group.windows:
                if window.floating:
                    window.cmd_bring_to_front()

    return __inner


keys = [
    # Qtile
    Key("A-k", lazy.layout.up()),
    Key("A-j", lazy.layout.down()),
    Key("A-h", lazy.layout.left()),
    Key("A-l", lazy.layout.right()),
    Key("A-S-k", lazy.layout.shuffle_up()),
    Key("A-S-j", lazy.layout.shuffle_down()),
    Key("A-S-h", lazy.layout.shuffle_left()),
    Key("A-S-l", lazy.layout.shuffle_right()),
    Key("A-C-S-h", lazy.layout.swap_column_left()),
    Key("A-C-S-l", lazy.layout.swap_column_right()),
    Key("A-<Tab>", lazy.layout.next()),
    Key("A-S-<Tab>", lazy.layout.previous()),
    Key("A-<space>", lazy.next_layout()),
    Key("A-S-f", lazy.window.toggle_floating()),
    Key("A-S-c", lazy.window.kill()),
    Key("A-S-r", lazy.restart()),
    Key("A-C-S-q", lazy.shutdown()),
    Key("M-S-f", float_to_front()),
    # Application Hotkeys
    Key("A-<Return>", lazy.spawn("kitty")),
    Key(
        "A-S-<Return>",
        lazy.spawn(os.path.expanduser("~/.config/rofi/scripts/launcher")),
    ),
    Key("A-S-e", lazy.spawn(f"{SCRIPTS}/rofimoji.sh")),
    Key("A-b", lazy.spawn("firefox -new-window")),
    Key("M-l", lazy.spawn("xset dpms force off")),
    Key("M-C-l", lazy.spawn("systemctl suspend")),
    Key("A-c", lazy.spawn("dunstctl close")),
    Key("A-<Escape>", lazy.spawn("dunstctl history-pop")),
    Key("A-m", lazy.spawn(f"{SCRIPTS}/Qminimize -m")),
    Key("A-S-m", lazy.spawn(f"{SCRIPTS}/Qminimize -u")),
    # Multimedia
    Key("<XF86AudioMute>", lazy.spawn("amixer -q set Master toggle")),
    Key("<XF86AudioLowerVolume>", lazy.spawn("amixer -q set Master 5%-")),
    Key("<XF86AudioRaiseVolume>", lazy.spawn("amixer -q set Master 5%+")),
    Key("<XF86AudioPlay>", lazy.spawn("playerctl play-pause")),
    Key("<XF86AudioNext>", lazy.spawn("playerctl next")),
    Key("<XF86AudioPrev>", lazy.spawn("playerctl previous")),
    Key("<XF86AudioStop>", lazy.spawn("playerctl stop")),
    Key("A-C-m", lazy.spawn(f"{SCRIPTS}/microphone.sh toggle")),
    # Backlight
    Key("<XF86MonBrightnessUp>", lazy.spawn("set_backlight.sh inc")),
    Key("<XF86MonBrightnessDown>", lazy.spawn("set_backlight.sh dec")),
    # Scripts
    Key("M-S-s", lazy.spawn(f"{SCRIPTS}/screenshot.sh select_no_save")),
]

mouse = [
    Drag(
        "M-1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        "M-3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click("M-2", lazy.window.bring_to_front()),
    Click("A-1", lazy.spawn(f"{SCRIPTS}/screenshot.sh select_no_save")),
]
