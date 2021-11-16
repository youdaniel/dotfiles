from libqtile.config import DropDown
from libqtile.config import EzKey as Key
from libqtile.config import Group, Match, ScratchPad
from libqtile.lazy import lazy

from keys import keys

group_defaults = {"label": "", "layout": "columns"}

group_config = [
    ("1", group_defaults),
    (
        "2",
        {
            **group_defaults,
            "matches": [Match(wm_class="discord"), Match(wm_class="slack")],
        },
    ),
    ("3", group_defaults),
    ("4", group_defaults),
    ("5", group_defaults),
    ("6", group_defaults),
    ("7", group_defaults),
    ("8", group_defaults),
    ("9", {**group_defaults, "matches": [Match(wm_class="obs")]}),
]

groups = [Group(name, **kwargs) for name, kwargs in group_config]

for i, (name, kwargs) in enumerate(group_config, 1):
    keys.extend(
        [
            Key(f"A-{i}", lazy.group[name].toscreen(toggle=True)),
            Key(f"A-S-{i}", lazy.window.togroup(name)),
        ]
    )

groups += [ScratchPad("SPD", dropdowns=[DropDown("python", "kitty -e python")])]

keys.extend([Key(f"A-S-p", lazy.group["SPD"].dropdown_toggle("python"))])
