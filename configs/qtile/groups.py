from libqtile.config import Group, Match, ScratchPad


def group_init():
    GROUPS = [
        Group("1", persist=True, init=True, position=1),
        Group("2", persist=True, init=True, position=2,
              matches=[Match(wm_class=["firefox"])]),
        Group("3", persist=True, init=True, position=3, matches=[
              Match(wm_class=["Emacs", "VSCodium"])]),
        Group("4", persist=True, init=True, position=4, matches=[
              Match(wm_class=["Org.gnome.Nautilus"])]),
        Group("5", persist=True, init=True, position=5,
              matches=[Match(title=["Spotify"], wm_instance_class=["spotify"], wm_class=["Spotify"])]),
        Group("6", persist=True, init=True, position=6,
              matches=[Match(wm_class=["discord"])]),
        Group("7", persist=True, init=True, position=7,
              matches=[Match(wm_class=["Steam"])]),
        Group("8", persist=True, init=True, position=8, matches=[
              Match(wm_class=["GitHub Desktop"])]),
        Group("9", persist=True, init=True, position=9,
              matches=[Match(wm_class=["Evolution"])]),
    ]
    return GROUPS
