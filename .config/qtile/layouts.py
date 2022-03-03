import os

from libqtile import layout
from libqtile.config import Match

layout_defaults = {
    "border_width": 0,
    "margin": 5,
    "border_focus": "#f8f8f2",
    "border_normal": "#282a36",
}

layouts = [
    layout.Columns(
        **layout_defaults, num_columns=(3 if not os.getenv("IS_LAPTOP") else 2)
    ),
    layout.Max(),
]


floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(wm_class="gcr-prompter"),
        Match(wm_class="pavucontrol"),
        Match(wm_class="Steam"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
        Match(title="League of Legends"),
    ],
    **layout_defaults
)
