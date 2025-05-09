import os

from libqtile import layout
from libqtile.config import Match

layout_defaults = {
    "border_width": 2,
    "margin": 5,
    "border_focus": "#cba6f7",
    "border_focus_stack": "#f5c2e7",
    "border_normal": "#282a36",
    "border_normal_stack": "#282a36",
}

layouts = [layout.Columns(**layout_defaults, num_columns=4)]


floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(wm_class="gcr-prompter"),
        Match(wm_class="pavucontrol"),
        Match(wm_class="steam"),
        Match(wm_class="battle.net.exe"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ],
    **layout_defaults
)
