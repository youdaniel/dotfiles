from libqtile import layout

layout_defaults = {
    "border_width": 2,
    "margin": 5,
    "border_focus": "#bd93f9",
    "border_normal": "#282a36",
}

layouts = [
    layout.MonadTall(**layout_defaults),
    layout.Max(**layout_defaults),
    layout.Bsp(**layout_defaults),
]

floating_layout = layout.Floating(
    auto_float_typesR=[
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "lxpolkit"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "notify"},
        {"wmclass": "popup_menu"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},
        {"wmclass": "makebranch"},
        {"wmclass": "maketag"},
        {"wname": "branchdialog"},
        {"wname": "pinentry"},
        {"wmclass": "ssh-askpass"},
    ],
    **layout_defaults
)
