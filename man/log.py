from man import InitClass as InitClass
from man import helpers as helpers
from man.colors import Colors as Colors


class Log(Colors, InitClass):
    def __init__(self):
        Colors.__init__(self)
        InitClass.__init__(self)

        self.off = {
            "name": "Off",
            "level": 10,
            "bg": self.bg["cyan"],
            "fg": self.fg["black"],
        }

        self.all = {
            "name": "All",
            "level": 0,
            "bg": self.bg["cyan"],
            "fg": self.fg["black"],
        }

        self.trace = {
            "name": "Trace",
            "level": 2,
            "bg": self.bg["cyan"],
            "fg": self.fg["black"],
        }

        self.debug = {
            "name": "Debug",
            "level": 3,
            "bg": self.bg["purple"],
            "fg": self.fg["black"],
        }

        self.info = {
            "name": "Info",
            "level": 4,
            "bg": self.bg["white"],
            "fg": self.fg["black"],
        }

        self.warn = {
            "name": "Warn",
            "level": 5,
            "bg": self.bg["orange"],
            "fg": self.fg["black"],
        }

        self.error = {
            "name": "Error",
            "level": 6,
            "bg": self.bg["red"],
            "fg": self.fg["black"],
        }

        self.fatal = {
            "name": "Fatal",
            "level": 7,
            "bg": self.bg["red"],
            "fg": self.fg["black"],
        }

        self.update = {
            "name": "Update",
            "level": 8,
            "bg": self.bg["yellow"],
            "fg": self.fg["black"],
        }

        self.success = {
            "name": "Success",
            "level": 9,
            "bg": self.bg["green"],
            "fg": self.fg["black"],
        }

        self.LOG_LEVEL = int(
            open(helpers.join(self.man_dir, "log_level.txt")).read())

    def log(self, text, type):
        name = type["name"]
        level = type["level"]
        bg = type["bg"]
        fg = type["fg"]

        if int(level) >= self.LOG_LEVEL:
            space = " "
            left_space = space
            right_space = space

            if name == self.trace["name"]:
                space = "  "
                left_space = space
                right_space = space
            elif name == self.debug["name"]:
                space = "  "
                left_space = space
                right_space = space
            elif name == self.info["name"]:
                space = "   "
                left_space = space
                right_space = "  "
            elif name == self.warn["name"]:
                space = "   "
                left_space = space
                right_space = "  "
            elif name == self.error["name"]:
                space = "  "
                left_space = space
                right_space = space
            elif name == self.fatal["name"]:
                space = "  "
                left_space = space
                right_space = space
            elif name == self.update["name"]:
                space = "  "
                left_space = space
                right_space = " "

            print(
                "{}{}{}{}{}{} {}".format(
                    bg,
                    fg,
                    left_space,
                    type["name"],
                    right_space,
                    self.style["reset"],
                    text,
                )
            )
