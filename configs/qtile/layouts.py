from libqtile import layout
from libqtile.config import Match


def layout_init():
    LAYOUTS = [
        layout.Columns(border_focus='#1b94d6', border_normal='#dfdfdf',
                       border_width=2, margin=5, margin_on_single=10),
        layout.Max(border_focus='#1b94d6', border_width=2, margin=5),
        layout.VerticalTile(border_focus='#1b94d6', border_width=2, margin=5),
        # Try more layouts by unleashing below layouts.
        # layout.Stack(num_stacks=3),
        # layout.Bsp(),
        # layout.Matrix(),
        # layout.MonadTall(),
        # layout.MonadWide(),
        # layout.RatioTile(),
        # layout.Tile(),
        # layout.TreeTab(),
        # layout.Zoomy(),
    ]
    return LAYOUTS


def floating_layouts():
    return layout.Floating(float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
        Match(title='Volume Control', wm_class='Pavucontrol'),
        Match(wm_class="Nvidia-settings"),
        Match(wm_class="MongoDB Compass"),
        Match(wm_class="Transmission-remote-gtk"),
        Match(wm_class="Blueman-manager"),
        Match(wm_class="Gnome-disks"),
        Match(wm_class="Pamac-manager"),
    ])
