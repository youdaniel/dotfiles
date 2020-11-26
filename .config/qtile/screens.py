import os
import subprocess

from libqtile import bar, widget
from libqtile.config import Screen

colors = [
    "#282a36",
    "#44475a",
    "#f8f8f2",
    "#6272a4",
    "#8be9fd",
    "#50fa7b",
    "#ffb86c",
    "#ff76c6",
    "#bd93f9",
    "#ff5555",
    "#f1fa8c",
]


def currently_playing():
    title = (
        subprocess.run(
            ["playerctl", "metadata", "title"], stdout=subprocess.PIPE
        )
        .stdout.decode("utf-8")
        .strip()
    )
    artist = (
        subprocess.run(
            ["playerctl", "metadata", "artist"], stdout=subprocess.PIPE
        )
        .stdout.decode("utf-8")
        .replace("- Topic", "")
        .strip()
    )
    artist = f" - {artist}" if artist else ""
    return f"♪ {title}{artist}".strip()


widget_defaults = dict(
    font="Ubuntu", fontsize=12, padding=2, background=colors[2]
)


def init_widgets_list():
    widgets = [
        widget.Sep(
            linewidth=0, padding=6, foreground=colors[2], background=colors[0]
        ),
        widget.GroupBox(
            font="Ubuntu Bold",
            fontsize=10,
            margin_y=3,
            margin_x=0,
            borderwidth=3,
            active=colors[2],
            inactive=colors[1],
            rounded=False,
            highlight_color=colors[0],
            highlight_method="line",
            this_current_screen_border=colors[8],
            this_screen_border=colors[8],
            other_current_screen_border=colors[0],
            other_screen_border=colors[0],
            foreground=colors[2],
            background=colors[0],
            disable_drag=True,
        ),
        widget.Sep(
            linewidth=0, padding=6, foreground=colors[2], background=colors[0]
        ),
        widget.WindowName(
            foreground=colors[5], background=colors[0], padding=0
        ),
        widget.TextBox(
            text=" ",
            padding=0,
            foreground=colors[2],
            background=colors[0],
            fontsize=12,
            mouse_callbacks={
                "Button1": lambda qtile: qtile.cmd_spawn("alacritty -e htop")
            },
        ),
        widget.CPU(
            format="CPU {freq_current}GHz {load_percent}%",
            update_interval=1.0,
            foreground=colors[2],
            background=colors[0],
            padding=5,
        ),
        widget.TextBox(
            text="/",
            background=colors[0],
            foreground=colors[8],
            padding=2,
            fontsize=14,
        ),
        widget.TextBox(
            text=" 🌡",
            padding=2,
            foreground=colors[2],
            background=colors[0],
            fontsize=11,
        ),
        widget.ThermalSensor(
            foreground=colors[2],
            background=colors[0],
            padding=5,
            tag_sensor="Package id 0",
        ),
        widget.TextBox(
            text="/",
            background=colors[0],
            foreground=colors[8],
            padding=2,
            fontsize=14,
        ),
        widget.TextBox(
            text=" 🖬",
            foreground=colors[2],
            background=colors[0],
            padding=0,
            fontsize=14,
        ),
        widget.Memory(foreground=colors[2], background=colors[0], padding=5,),
        widget.TextBox(
            text="/",
            background=colors[0],
            foreground=colors[8],
            padding=2,
            fontsize=14,
        ),
        widget.Net(
            interface="eno1",
            format="{down} ↓↑ {up}",
            foreground=colors[2],
            background=colors[0],
            padding=5,
        ),
        widget.TextBox(
            text="/",
            background=colors[0],
            foreground=colors[8],
            padding=2,
            fontsize=14,
        ),
        widget.TextBox(
            text=" Vol:", foreground=colors[2], background=colors[0], padding=0
        ),
        widget.Volume(foreground=colors[2], background=colors[0], padding=5),
        widget.TextBox(
            text="/",
            background=colors[0],
            foreground=colors[8],
            padding=2,
            fontsize=14,
        ),
        widget.GenPollText(
            foreground=colors[2],
            background=colors[0],
            padding=5,
            update_interval=1,
            func=currently_playing,
            markup=False,
            mouse_callbacks={
                "Button2": lambda qtile: qtile.cmd_spawn(
                    "playerctl play-pause"
                ),
                "Button1": lambda qtile: qtile.cmd_spawn("playerctl previous"),
                "Button3": lambda qtile: qtile.cmd_spawn("playerctl next"),
            },
        ),
        widget.TextBox(
            text="/",
            background=colors[0],
            foreground=colors[8],
            padding=2,
            fontsize=14,
        ),
        widget.CurrentLayout(
            foreground=colors[2], background=colors[0], padding=5
        ),
        widget.TextBox(
            text="/",
            background=colors[0],
            foreground=colors[8],
            padding=2,
            fontsize=14,
        ),
        widget.Clock(
            foreground=colors[2],
            background=colors[0],
            format="%A, %B %d  [ %I:%M %p ]",
        ),
    ]
    return widgets


screens = [
    Screen(top=bar.Bar(widgets=init_widgets_list(), opacity=1, size=22)),
    Screen(top=bar.Bar(widgets=init_widgets_list(), opacity=1, size=20)),
]
