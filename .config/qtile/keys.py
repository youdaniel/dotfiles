from libqtile.config import EzClick as Click
from libqtile.config import EzDrag as Drag
from libqtile.config import EzKey as Key
from libqtile.lazy import lazy


def float_to_front():
    @lazy.function
    def __inner(qtile):
        for group in qtile.groups:
            for window in group.windows:
                if window.floating:
                    window.cmd_bring_to_front()

    return __inner


def window_to_previous_screen():
    @lazy.function
    def __inner(qtile):
        i = qtile.screens.index(qtile.current_screen)
        if i != 0:
            group = qtile.screens[i - 1].group.name
            qtile.current_window.togroup(group)

    return __inner


def window_to_next_screen():
    @lazy.function
    def __inner(qtile):
        i = qtile.screens.index(qtile.current_screen)
        if i + 1 != len(qtile.screens):
            group = qtile.screens[i + 1].group.name
            qtile.current_window.togroup(group)

    return __inner


def switch_screens():
    @lazy.function
    def __inner(qtile):
        i = qtile.screens.index(qtile.current_screen)
        group = qtile.screens[i - 1].group
        qtile.current_screen.set_group(group)

    return __inner


keys = [
    Key("A-w", lazy.to_screen(0)),
    Key("A-e", lazy.to_screen(1)),
    Key("A-S-w", window_to_previous_screen()),
    Key("A-S-e", window_to_next_screen()),
    Key("A-s", switch_screens()),
    Key("A-k", lazy.layout.up()),
    Key("A-j", lazy.layout.down()),
    Key("A-h", lazy.layout.left()),
    Key("A-l", lazy.layout.right()),
    Key("A-S-k", lazy.layout.shuffle_up()),
    Key("A-S-j", lazy.layout.shuffle_down()),
    Key("A-S-h", lazy.layout.shuffle_left()),
    Key("A-S-l", lazy.layout.shuffle_right()),
    Key(
        "A-C-k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key(
        "A-C-j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),
    Key(
        "A-C-h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key(
        "A-C-l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key("A-M-k", lazy.layout.flip_up()),
    Key("A-M-j", lazy.layout.flip_down()),
    Key("A-M-h", lazy.layout.flip_left()),
    Key("A-M-l", lazy.layout.flip_right()),
    Key("A-n", lazy.layout.normalize()),
    Key("A-<Tab>", lazy.layout.next()),
    Key("A-<space>", lazy.next_layout()),
    Key("A-S-<space>", lazy.layout.flip()),
    Key("A-S-m", lazy.window.toggle_fullscreen()),
    Key("A-S-f", lazy.window.toggle_floating()),
    Key("A-S-c", lazy.window.kill()),
    Key("A-S-r", lazy.restart()),
    Key("A-S-q", lazy.shutdown()),
    Key("M-S-f", float_to_front()),
    # Application Hotkeys
    Key("A-<Return>", lazy.spawn("alacritty")),
    Key("A-S-<Return>", lazy.spawn("rofi -monitor -4 -show")),
    Key("A-b", lazy.spawn("firefox -new-window")),
    Key("M-l", lazy.spawn("xset dpms force off")),
    Key("M-C-l", lazy.spawn("systemctl suspend")),
    # Multimedia
    Key("<XF86AudioMute>", lazy.spawn("amixer -q set Master toggle")),
    Key("<XF86AudioLowerVolume>", lazy.spawn("amixer -q set Master 5%-")),
    Key("<XF86AudioRaiseVolume>", lazy.spawn("amixer -q set Master 5%+")),
    Key("<XF86AudioPlay>", lazy.spawn("playerctl play-pause")),
    Key("<XF86AudioNext>", lazy.spawn("playerctl next")),
    Key("<XF86AudioPrev>", lazy.spawn("playerctl previous")),
    Key("<XF86AudioStop>", lazy.spawn("playerctl stop")),
    Key("A-C-m", lazy.spawn("toggle_microphone.sh")),
    # Scripts
    Key("A-C-w", lazy.spawn("wacom_display_toggle.sh")),
    Key("<Print>", lazy.spawn("screenshot.sh select_no_save")),
    Key("S-<Print>", lazy.spawn("screenshot.sh select")),
    Key("C-<Print>", lazy.spawn("screenshot.sh select_window")),
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
    Click("A-1", lazy.spawn("screenshot.sh select_no_save")),
    Click("A-S-1", lazy.spawn("screenshot.sh select")),
    Click("A-C-1", lazy.spawn("screenshot.sh select_window")),
]
