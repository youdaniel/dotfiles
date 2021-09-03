from libqtile import layout
from libqtile.config import Match

layout_defaults = {
    "border_width": 2,
    "margin": 10,
    "border_focus": "#f8f8f2",
    "border_normal": "#282a36",
}

layouts = [
    layout.MonadTall(**layout_defaults),
    layout.Bsp(**layout_defaults),
]

floating_layout = layout.Floating(
    float_rules=[
        Match(wm_type="utility"),
        Match(wm_type="notification"),
        Match(wm_type="toolbar"),
        Match(wm_type="splash"),
        Match(wm_type="dialog"),
        Match(wm_class="file_progress"),
        Match(wm_class="confirm"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="notification"),
        Match(wm_class="splash"),
        Match(wm_class="toolbar"),
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(wm_class="gcr-prompter"),
        Match(wm_class="pavucontrol"),
        Match(wm_class="pokerstars.exe"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
        Match(title="League of Legends"),
    ],
    **layout_defaults
)
