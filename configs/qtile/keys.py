from libqtile.config import Key, Drag, Click
from libqtile.lazy import lazy

mod = "mod4"
terminal = "kitty"


def key_maps():

    return [
        # Switch between windows
        Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
        Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
        Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
        Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
        Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
        Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
        #Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

        # Move windows between left/right columns or move up/down in current stack.
        # Moving out of range in Columns layout will create new column.
        Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
            desc="Move window to the left"),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
            desc="Move window to the right"),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
            desc="Move window down"),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
        Key([mod, "shift"], "Left", lazy.layout.shuffle_left(),
            desc="Move window to the left"),
        Key([mod, "shift"], "Right", lazy.layout.shuffle_right(),
            desc="Move window to the right"),
        Key([mod, "shift"], "Down", lazy.layout.shuffle_down(),
            desc="Move window down"),
        Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),

        # Grow windows. If current window is on the edge of screen and direction
        # will be to screen edge - window would shrink.
        Key([mod, "control"], "h", lazy.layout.grow_left(),
            desc="Grow window to the left"),
        Key([mod, "control"], "l", lazy.layout.grow_right(),
            desc="Grow window to the right"),
        Key([mod, "control"], "j", lazy.layout.grow_down(),
            desc="Grow window down"),
        Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
        Key([mod, "control"], "Left", lazy.layout.grow_left(),
            desc="Grow window to the left"),
        Key([mod, "control"], "Right", lazy.layout.grow_right(),
            desc="Grow window to the right"),
        Key([mod, "control"], "Down", lazy.layout.grow_down(),
            desc="Grow window down"),
        Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
        Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack"),
        Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

        # Toggle between different layouts as defined below
        Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
        Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
        Key([mod, "shift"], "n", lazy.window.toggle_minimize(), desc="Minimize window"),
        Key([mod, "shift"], "space", lazy.window.toggle_floating(), desc="Minimize window"),

        Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
        Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
        # LAUNCHERS
        Key([mod], "space", lazy.spawn("dmenu_run"),
            desc="Spawn dmenu"),
        Key([mod, "control"], "s", lazy.spawn("i3exit suspend"),
            desc="Suspend System"), 
        Key([mod, "mod1"], "l", lazy.spawn("blurlock"),
         desc="Spawn a command using a prompt widget"), 
        Key([mod, "shift"], "m", lazy.spawn(terminal + " bpytop"),
         desc="launch bpytop"), 
        Key([mod, "shift"], "g", lazy.spawn(terminal + " watch -n 1 nvidia-smi"), 
         desc="GPU monitor"),
        Key([mod, "shift"], "b", lazy.spawn("firefox"), 
         desc="GPU monitor"),
        Key([mod, "shift"], "e", lazy.spawn("emacs"), 
         desc="GPU monitor"),
        Key([mod, "shift"], "c", lazy.spawn("vscodium"), 
         desc="GPU monitor"),
    ]


def mouse_init():
    MOUSE = [
        Drag([mod], "Button1", lazy.window.set_position_floating(),
             start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(),
             start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front())
    ]
    return MOUSE


def group_keys(groups, keys):
    for i in groups:
        keys.extend([
            # mod1 + letter of group = switch to group
            Key([mod], i.name, lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name)),

            # mod1 + shift + letter of group = switch to & move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            #    desc="Switch to & move focused window to group {}".format(i.name)),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name)),
        ])
