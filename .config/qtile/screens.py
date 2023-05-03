import os
import subprocess

from libqtile import bar, qtile, widget
from libqtile.config import Screen
from qtile_extras.widget import modify
from qtile_extras.widget.decorations import RectDecoration

from extras.groupbox import GroupBox

colors = {
    "bg": "#313244",
    "fg": "#cdd6f4",
    "pink": "#f5c2e7",
    "mauve": "#cba6f7",
    "red": "#f38ba8",
    "peach": "fab387",
    "green": "#a6e3a1",
    "yellow": "#f9e2af",
    "blue": "#89b4fa",
    "teal": "#94e2d5",
    "white": "#bac2de",
}
transparent = "#00000000"


def currently_playing():
    def get_metadata(metadata_type: str):
        return (
            subprocess.run(
                ["playerctl", "metadata", "-p", "spotify", metadata_type],
                stdout=subprocess.PIPE,
            )
            .stdout.decode("utf-8")
            .strip()
        )

    title = get_metadata("title")
    title = (title[:30] + "..") if len(title) > 30 else title

    artist = get_metadata("artist")
    artist = (artist[:20] + "..") if len(artist) > 20 else artist
    artist = f" - {artist}" if artist else ""

    return f"{title}{artist}".rstrip() if title else ""


def music_icon():
    return " " if len(currently_playing()) > 0 else ""


def transparent_separator(padding=10):
    return widget.Sep(padding=padding, linewidth=0)


def base(
    font: str = "UbuntuMono Nerd Font Mono",
    fontsize: int = 14,
    padding: int = 0,
    bg: str = colors["bg"],
    fg: str = colors["fg"],
) -> dict:
    return {
        "font": font,
        "fontsize": fontsize,
        "padding": padding,
        "background": bg,
        "foreground": fg,
    }


def icon_font(bg: str = colors["bg"], fg: str = colors["fg"]) -> dict:
    return base(font="Font Awesome 6 Free Solid", fontsize=12, padding=2, bg=bg, fg=fg)


def rectangle(side: str = "", r: int = 10) -> dict:
    return {
        "decorations": [
            RectDecoration(
                filled=True,
                radius={"left": [r, 0, 0, r], "right": [0, r, r, 0]}.get(side, r),
                use_widget_background=True,
            ),
        ],
    }


def wrap_widgets(*widgets, sep=True):
    wrapped = [
        modify(widget.Sep, **base(padding=8, fg=colors["bg"]), **rectangle("left")),
        *widgets,
        modify(widget.Sep, **base(padding=8, fg=colors["bg"]), **rectangle("right")),
    ]
    if sep:
        wrapped.append(transparent_separator())
    return wrapped


def clock(icon, fmt: str, fg: str = colors["fg"], sep: bool = True) -> list:
    return wrap_widgets(icon, modify(widget.Clock, **base(fg=fg), format=fmt), sep=sep)


def audio(vol_fg=colors["teal"], music_fg=colors["green"]) -> list:
    return wrap_widgets(
        modify(widget.TextBox, **icon_font(fg=vol_fg), text=" "),
        modify(widget.Volume, **base(fg=vol_fg)),
        modify(widget.Sep, **base(fg=colors["bg"], padding=5)),
        modify(
            widget.GenPollText,
            **icon_font(fg=music_fg),
            update_interval=1,
            func=music_icon,
        ),
        modify(
            widget.GenPollText,
            **base(fg=music_fg),
            update_interval=1,
            func=currently_playing,
            markup=False,
            mouse_callbacks={
                "Button2": lambda: qtile.cmd_spawn("playerctl play-pause -p spotify"),
                "Button1": lambda: qtile.cmd_spawn("playerctl previous -p spotify"),
                "Button3": lambda: qtile.cmd_spawn("playerctl next -p spotify"),
            },
        ),
    )


def systray():
    return modify(widget.Systray, **base(bg=transparent))


def groups():
    return modify(
        GroupBox,
        **base(bg=transparent, padding=2),
        highlight_method="text",
        borderwidth=0,
        active=colors["fg"],
        inactive=colors["bg"],
        this_current_screen_border=colors["red"],
        this_screen_border=colors["red"],
        other_screen_border=colors["fg"],
        other_current_screen_border=colors["fg"],
        disable_drag=True,
        use_mouse_wheel=False,
    )


def cpu(fg: str = colors["blue"]) -> list:
    return wrap_widgets(
        modify(widget.TextBox, **icon_font(fg=fg), text=" "),
        modify(
            widget.CPU,
            **base(fg=fg),
            format="CPU {load_percent}%",
            update_interval=1,
        ),
        modify(
            widget.ThermalSensor,
            **base(fg=fg),
            tag_sensor="Package id 0" if os.getenv("IS_LAPTOP") else "Tctl",
            threshold=90,
            format=" ({temp:.1f}{unit})",
        ),
    )


def mem(fg: str = colors["peach"]):
    return wrap_widgets(
        modify(widget.TextBox, **icon_font(fg=fg), text=" "),
        modify(
            widget.Memory,
            **base(fg=fg),
            measure_mem="G",
            format="{MemUsed:.2f} GB",
        ),
    )


def battery():
    return wrap_widgets(
        modify(
            widget.Battery,
            **base(),
            charge_char="",
            discharge_char="",
            format="{char}{percent:2.0%} {hour:d}:{min:02d} left",
        )
    )


def net(fg: str = colors["mauve"]):
    return wrap_widgets(
        modify(widget.TextBox, **icon_font(fg=fg), text=" "),
        modify(widget.Net, **base(fg=fg), format="{down} ↓↑{up}"),
    )


def init_widgets_list(show_systray=True):
    widgets = []
    widgets.extend(
        clock(
            modify(widget.TextBox, **icon_font(fg=colors["yellow"]), text=" "),
            fmt="%A, %B %d",
            fg=colors["yellow"],
        )
    )
    widgets.extend(audio())

    if show_systray:
        widgets.append(systray())

    widgets.append(widget.Spacer())
    widgets.append(groups())
    widgets.append(widget.Spacer())

    widgets.extend(cpu())
    widgets.extend(mem())
    widgets.extend(net())

    if os.getenv("IS_LAPTOP"):
        widgets.extend(battery())

    widgets.extend(
        clock(
            modify(widget.TextBox, **icon_font(fg=colors["pink"]), text=" "),
            fmt="%I:%M %p",
            fg=colors["pink"],
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
        ),
        bottom=bar.Gap(5),
        left=bar.Gap(5),
        right=bar.Gap(5),
    ),
    Screen(
        top=bar.Bar(
            widgets=init_widgets_list(show_systray=False),
            opacity=1,
            size=25,
            margin=[10, 10, 5, 10],
            background=transparent,
        ),
        bottom=bar.Gap(5),
        left=bar.Gap(5),
        right=bar.Gap(5),
    ),
]
