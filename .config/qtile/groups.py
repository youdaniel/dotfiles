from libqtile.config import DropDown
from libqtile.config import EzKey as Key
from libqtile.config import Group, Match, ScratchPad
from libqtile.lazy import lazy

from keys import keys

group_config = [
    ("I", {"layout": "columns"}),
    (
        "II",
        {
            "layout": "columns",
            "matches": [Match(wm_class="discord"), Match(wm_class="slack")],
        },
    ),
    ("III", {"layout": "columns"}),
    ("IV", {"layout": "columns"}),
    ("V", {"layout": "columns"}),
    ("VI", {"layout": "columns"}),
    ("VII", {"layout": "columns"}),
    ("VIII", {"layout": "columns"}),
    ("IX", {"layout": "columns", "matches": [Match(wm_class="obs")]}),
]

groups = [Group(name, **kwargs) for name, kwargs in group_config]

for i, (name, kwargs) in enumerate(group_config, 1):
    keys.extend(
        [
            Key(f"A-{i}", lazy.group[name].toscreen()),
            Key(f"A-S-{i}", lazy.window.togroup(name)),
        ]
    )

groups += [ScratchPad("SPD", dropdowns=[DropDown("python", "alacritty -e python")])]

keys.extend([Key(f"A-S-p", lazy.group["SPD"].dropdown_toggle("python"))])
