#!/usr/bin/python3.10

from man import helpers as helpers
from man import variables as variables

from man.operations.template import Template as Template
from man.operations.file import Files as Files


Template(
    'dotfiles/templates/.gitconfig',
    '~/.gitconfig',
    values={
        "user":         variables.USER,
        "credential":   variables.CREDENTIAL,
        "github":       variables.GITHUB,
        "commit":       variables.COMMIT,
    }
).copy_to_destination()

Files(helpers.join(variables.ASPECTS, 'dotfiles', 'files'), values={
    "zsh":                  helpers.join(variables.CONFIG, "zsh"),
    ".zshrc":               helpers.join(variables.CONFIG, "zsh", ".zshrc"),
    ".zshenv":              helpers.join(variables.HOME, ".zshenv"),
    "tmux.conf":            helpers.join(variables.CONFIG, "tmux", "tmux.conf"),
    ".xprofile":            helpers.join(variables.HOME, ".xprofile"),
    ".config/anki":         helpers.join(variables.CONFIG, "anki"),
    ".config/awesome":      helpers.join(variables.CONFIG, "awesome"),
    ".config/bspwm":        helpers.join(variables.CONFIG, "bspwm"),
    ".config/castero":      helpers.join(variables.CONFIG, "castero"),
    ".config/chameleon":    helpers.join(variables.CONFIG, "chameleon"),
    ".config/dunst":        helpers.join(variables.CONFIG, "dunst"),
    ".config/gnuplot":      helpers.join(variables.CONFIG, "gnuplot"),
    ".config/khal":         helpers.join(variables.CONFIG, "khal"),
    ".config/khard":        helpers.join(variables.CONFIG, "khard"),
    ".config/lf":           helpers.join(variables.CONFIG, "lf"),
    ".config/lynx":         helpers.join(variables.CONFIG, "lynx"),
    ".config/mpd":          helpers.join(variables.CONFIG, "mpd"),
    ".config/mpv":          helpers.join(variables.CONFIG, "mpv"),
    ".config/ncmpcpp":      helpers.join(variables.CONFIG, "ncmpcpp"),
    ".config/neofetch":     helpers.join(variables.CONFIG, "neofetch"),
    ".config/neomutt":      helpers.join(variables.CONFIG, "neomutt"),
    ".config/newsboat":     helpers.join(variables.CONFIG, "newsboat"),
    ".config/picom":        helpers.join(variables.CONFIG, "picom"),
    ".config/polybar":      helpers.join(variables.CONFIG, "polybar"),
    ".config/ranger":       helpers.join(variables.CONFIG, "ranger"),
    ".config/rofi":         helpers.join(variables.CONFIG, "rofi"),
    ".config/sioyek":       helpers.join(variables.CONFIG, "sioyek"),
    ".config/spicetify":    helpers.join(variables.CONFIG, "spicetify"),
    ".config/sxhkd":        helpers.join(variables.CONFIG, "sxhkd"),
    ".config/wal":          helpers.join(variables.CONFIG, "wal"),
    ".config/wal-discord":  helpers.join(variables.CONFIG, "wal-discord"),
    ".config/weechat":      helpers.join(variables.CONFIG, "weechat"),
})
