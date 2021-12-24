from screeninfo import get_monitors
from libqtile import bar
from libqtile.config import Screen


def screen_init():
    #SCREEN_NUM = 1
    SCREEN_NUM = len(get_monitors())
    if SCREEN_NUM == 2:
        return [
            Screen(bottom=bar.Gap(size=10), top=bar.Gap(size=38)),
            Screen(bottom=bar.Gap(size=10), top=bar.Gap(size=38))
        ]
    else:
        return [
            Screen(bottom=bar.Gap(size=10), top=bar.Gap(size=38))
        ]
