import os
import subprocess

from libqtile import bar, qtile, widget
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
        subprocess.run(["playerctl", "metadata", "title"], stdout=subprocess.PIPE)
        .stdout.decode("utf-8")
        .strip()
    )
    artist = (
        subprocess.run(["playerctl", "metadata", "artist"], stdout=subprocess.PIPE)
        .stdout.decode("utf-8")
        .replace("- Topic", "")
        .strip()
    )
    artist = f" - {artist}" if artist else ""
    return f"♪ {title}{artist}".strip()


widget_defaults = dict(font="Ubuntu", fontsize=12, padding=7, background=colors[2])


def slashSeparator():
    return widget.TextBox(
        text="/",
        foreground=colors[8],
        fontsize=14,
    )


def init_widgets_list(is_laptop=os.getenv("IS_LAPTOP")):
    widgets = []
    widgets.append(
        widget.GroupBox(
            font="Ubuntu Bold",
            fontsize=10,
            borderwidth=0,
            active=colors[2],
            inactive=colors[1],
            rounded=True,
            highlight_method="block",
            highlight_color=colors[0],
            this_current_screen_border=colors[8],
            this_screen_border=colors[8],
            other_current_screen_border=colors[0],
            other_screen_border=colors[0],
            disable_drag=True,
        )
    )
    widgets.append(widget.Sep(linewidth=0))
    widgets.append(widget.WindowName(foreground=colors[5]))
    widgets.append(
        widget.CPU(format="CPU {freq_current}GHz {load_percent}%", update_interval=1.0)
    )
    widgets.append(slashSeparator())
    widgets.append(
        widget.ThermalSensor(
            foreground=colors[2],
            tag_sensor="Package id 0" if is_laptop else "Tctl",
            threshold=90,
        )
    )
    widgets.append(slashSeparator())
    widgets.append(widget.Memory())
    widgets.append(slashSeparator())
    widgets.append(
        widget.Net(
            interface="wlp2s0" if is_laptop else "eno1",
            format="{down} ↓↑ {up}",
        )
    )
    if is_laptop:
        widgets.append(slashSeparator())
        widgets.append(
            widget.Battery(
                charge_char="",
                discharge_char="",
                format="{char}{percent:2.0%} {hour:d}:{min:02d} left",
            )
        )
    widgets.append(slashSeparator())
    widgets.append(widget.TextBox(text="Vol:"))
    widgets.append(widget.Volume())
    if not is_laptop:
        widgets.append(slashSeparator())
        widgets.append(
            widget.GenPollText(
                update_interval=1,
                func=currently_playing,
                markup=False,
                mouse_callbacks={
                    "Button2": lambda: qtile.cmd_spawn("playerctl play-pause"),
                    "Button1": lambda: qtile.cmd_spawn("playerctl previous"),
                    "Button3": lambda: qtile.cmd_spawn("playerctl next"),
                },
            )
        )
    widgets.append(slashSeparator())
    widgets.append(
        widget.Clock(
            format="%a, %b %d  [ %I:%M %p ]",
        )
    )
    return widgets


screens = [
    Screen(
        top=bar.Bar(
            widgets=init_widgets_list(),
            opacity=1,
            size=25,
            margin=[10, 10, 5, 10],
            background=colors[0],
            foreground=colors[2],
        ),
        bottom=bar.Gap(5),
        left=bar.Gap(5),
        right=bar.Gap(5),
    ),
]
