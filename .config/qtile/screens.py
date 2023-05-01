import os
import subprocess

from libqtile import bar, qtile, widget
from libqtile.config import Screen

from extras.groupbox import GroupBox

colors = {
    "bg": "#313244",
    "fg": "#cdd6f4",
    "black": "#11111b",
    "red": "#f38ba8",
    "green": "#a6e3a1",
    "yellow": "#f9e2af",
    "blue": "#89b4fa",
    "pink": "#f5c2e7",
    "teal": "#94e2d5",
    "white": "#bac2de",
}
transparent = "#00000000"
widget_defaults = dict(font="UbuntuMono Nerd Font Mono", fontsize=14, padding=2)


def mic_status():
    mic_status = (
        subprocess.run(
            [f"{os.getenv('HOME')}/.config/qtile/scripts/microphone.sh", "status"],
            stdout=subprocess.PIPE,
        )
        .stdout.decode("utf-8")
        .strip()
    )
    return " (M)" if mic_status == "off" else " (UM)"


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
    title = (title[:30] + "..") if len(title) > 30 else title

    artist = get_metadata("artist")
    artist = (artist[:20] + "..") if len(artist) > 20 else artist
    artist = f" - {artist}" if artist else ""

    return f" ♪ {title}{artist}".rstrip() if title else ""


def transparent_separator(padding=10):
    return widget.Sep(padding=padding, linewidth=0)


def bubble_widget(*widgets, sep=True):
    bubble_attrs = dict(
        font="UbuntuMono Nerd Font Mono",
        foreground=getattr(widgets[0], "background", colors["bg"]),
        padding=0,
        fontsize=26,
    )

    widgets = [
        widget.TextBox(text="\ue0b6", **bubble_attrs),
        *widgets,
        widget.TextBox(text="\ue0b4", **bubble_attrs),
    ]

    if sep:
        widgets.append(transparent_separator())

    return widgets


def init_widgets_list(systray=True, is_laptop=os.getenv("IS_LAPTOP")):
    widgets = []
    widgets.extend(
        bubble_widget(
            widget.Clock(**widget_defaults, background=colors["bg"], format="%A, %B %d")
        ),
    )

    audio_widgets = [
        widget.Volume(**widget_defaults, fmt="Vol: {}", background=colors["bg"]),
        widget.GenPollText(
            **widget_defaults,
            update_interval=1,
            func=mic_status,
            markup=False,
            background=colors["bg"],
        ),
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
            background=colors["bg"],
        ),
    ]
    widgets.extend(bubble_widget(*audio_widgets))

    if systray:
        widgets.append(widget.Systray(**widget_defaults, background=transparent))

    widgets.append(widget.Spacer())
    widgets.append(
        GroupBox(
            **widget_defaults,
            highlight_method="text",
            borderwidth=0,
            active=colors["fg"],
            inactive=colors["bg"],
            this_current_screen_border=colors["green"],
            this_screen_border=colors["green"],
            other_screen_border=colors["fg"],
            other_current_screen_border=colors["fg"],
            disable_drag=True,
            use_mouse_wheel=False,
            background=transparent,
        )
    )
    widgets.append(widget.Spacer())

    widgets.extend(
        bubble_widget(
            widget.CPU(
                **widget_defaults,
                format="CPU {load_percent}%",
                update_interval=1.0,
                background=colors["bg"],
            ),
            widget.TextBox(**widget_defaults, text="|", background=colors["bg"]),
            widget.ThermalSensor(
                **widget_defaults,
                tag_sensor="Package id 0" if is_laptop else "Tctl",
                threshold=90,
                background=colors["bg"],
            ),
        )
    )

    widgets.extend(
        bubble_widget(
            widget.Memory(
                **widget_defaults,
                background=colors["bg"],
                measure_mem="G",
                format="{MemUsed:.2f} GB",
            )
        )
    )

    widgets.extend(
        bubble_widget(
            widget.Net(
                **widget_defaults,
                format="{down} ↓↑{up}",
                background=colors["bg"],
            )
        )
    )

    if is_laptop:
        widgets.extend(
            bubble_widget(
                widget.Battery(
                    **widget_defaults,
                    charge_char="",
                    discharge_char="",
                    format="{char}{percent:2.0%} {hour:d}:{min:02d} left",
                    background=colors["bg"],
                )
            )
        )

    widgets.extend(
        bubble_widget(
            widget.Clock(
                **widget_defaults,
                format="%I:%M %p",
                background=colors["bg"],
            ),
            sep=False,
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
            foreground=colors["fg"],
        ),
        bottom=bar.Gap(5),
        left=bar.Gap(5),
        right=bar.Gap(5),
    ),
    Screen(
        top=bar.Bar(
            widgets=init_widgets_list(systray=False),
            opacity=1,
            size=25,
            margin=[10, 10, 5, 10],
            background=transparent,
            foreground=colors["fg"],
        ),
        bottom=bar.Gap(5),
        left=bar.Gap(5),
        right=bar.Gap(5),
    ),
]
