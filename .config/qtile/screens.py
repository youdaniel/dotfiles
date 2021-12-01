import os
import subprocess
from typing import List

from libqtile import bar, qtile, widget
from libqtile.config import Screen

colors = {
    "background": "#282a36",
    "selection": "#44475a",
    "white": "#f8f8f2",
    "comment": "#6272a4",
    "cyan": "#8be9fd",
    "green": "#50fa7b",
    "orange": "#ffb86c",
    "pink": "#ff76c6",
    "purple": "#bd93f9",
    "red": "#ff5555",
    "yellow": "#f1fa8c",
}
transparent = "#00000000"
widget_defaults = dict(font="UbuntuMono Nerd Font Bold", fontsize=14, padding=2)


def currently_playing():
    def get_metadata(metadata_type: str):
        return (
            subprocess.run(
                ["playerctl", "metadata", metadata_type], stdout=subprocess.PIPE
            )
            .stdout.decode("utf-8")
            .strip()
        )

    title = get_metadata("title")
    title = (title[:25] + "..") if len(title) > 25 else title

    artist = get_metadata("artist")
    artist = (artist[:20] + "..") if len(artist) > 30 else artist
    artist = f" - {artist}" if artist else ""

    return f" ♪ {title}{artist}".rstrip() if title else ""


def transparent_separator(padding=10):
    return widget.Sep(padding=padding, linewidth=0)


def bubble_widget(middle_widget: List):
    bubble_attrs = dict(
        font="UbuntuMono Nerd Font Mono",
        foreground=getattr(middle_widget[0], "background", colors["background"]),
        padding=0,
        fontsize=26,
    )

    widgets = [
        widget.TextBox(text="\ue0b6", **bubble_attrs),
        widget.TextBox(text="\ue0b4", **bubble_attrs),
    ]
    widgets[1:1] = middle_widget

    return widgets


def init_widgets_list(is_laptop=os.getenv("IS_LAPTOP")):
    widgets = []
    widgets.extend(
        bubble_widget(
            [
                widget.Clock(
                    **widget_defaults,
                    background=colors["selection"],
                    format="%A, %B %d",
                )
            ],
        )
    )
    widgets.append(transparent_separator())

    vol_music = [
        widget.Volume(**widget_defaults, fmt="Vol: {}", background=colors["purple"])
    ]
    if not is_laptop:
        vol_music.append(
            widget.GenPollText(
                **widget_defaults,
                update_interval=1,
                func=currently_playing,
                markup=False,
                mouse_callbacks={
                    "Button2": lambda: qtile.cmd_spawn("playerctl play-pause"),
                    "Button1": lambda: qtile.cmd_spawn("playerctl previous"),
                    "Button3": lambda: qtile.cmd_spawn("playerctl next"),
                },
                background=colors["purple"],
            )
        )
    widgets.extend(bubble_widget(vol_music))
    widgets.append(transparent_separator())
    widgets.append(widget.Systray(**widget_defaults, background=transparent))
    widgets.append(widget.Spacer())
    widgets.extend(
        bubble_widget(
            [
                widget.GroupBox(
                    **widget_defaults,
                    borderwidth=0,
                    active=colors["white"],
                    inactive=colors["selection"],
                    rounded=True,
                    highlight_color=transparent,
                    block_highlight_text_color=colors["green"],
                    disable_drag=True,
                    background=transparent,
                )
            ]
        )
    )

    widgets.append(widget.Spacer())
    widgets.extend(
        bubble_widget(
            [
                widget.CPU(
                    **widget_defaults,
                    format="CPU {load_percent}%",
                    update_interval=1.0,
                    background=colors["red"],
                ),
                widget.TextBox(**widget_defaults, text="|", background=colors["red"]),
                widget.ThermalSensor(
                    **widget_defaults,
                    tag_sensor="Package id 0" if is_laptop else "Tctl",
                    threshold=90,
                    background=colors["red"],
                ),
            ]
        )
    )
    widgets.append(transparent_separator())
    widgets.extend(
        bubble_widget(
            [
                widget.Memory(
                    **widget_defaults,
                    background=colors["orange"],
                    measure_mem="G",
                    format="{MemUsed:.2f} GB",
                )
            ]
        )
    )
    widgets.append(transparent_separator())
    widgets.extend(
        bubble_widget(
            [
                widget.Net(
                    **widget_defaults,
                    interface="wlp2s0" if is_laptop else "eno1",
                    format="{down} ↓↑{up}",
                    background=colors["pink"] if is_laptop else colors["purple"],
                )
            ]
        )
    )
    widgets.append(transparent_separator())
    if is_laptop:
        widgets.extend(
            bubble_widget(
                [
                    widget.Battery(
                        **widget_defaults,
                        charge_char="",
                        discharge_char="",
                        format="{char}{percent:2.0%} {hour:d}:{min:02d} left",
                        background=colors["purple"],
                    )
                ]
            )
        )
        widgets.append(transparent_separator())
    widgets.extend(
        bubble_widget(
            [
                widget.Clock(
                    **widget_defaults,
                    format="%I:%M %p",
                    background=colors["selection"],
                )
            ]
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
            background=transparent,
            foreground=colors["white"],
        ),
        bottom=bar.Gap(5),
        left=bar.Gap(5),
        right=bar.Gap(5),
    ),
]
