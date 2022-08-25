import os

from man import InitClass as InitClass
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

        if os.path.exists(self.log_level_txt):
            self.LOG_LEVEL = int(open(self.log_level_txt).read())
        else:
            self.LOG_LEVEL = 3

    def log_format(self, type, text, spacing_number):
        if int(type["level"]) >= self.LOG_LEVEL:
            spacing = " " * spacing_number

            print(
                "{}{} {}{}{} {}".format(
                    type["bg"],
                    type["fg"],
                    type["name"],
                    spacing,
                    self.style["reset"],
                    text,
                )
            )

    def log_trace(self, text):
        self.log_format(self.trace, text, 3)

    def log_debug(self, text):
        self.log_format(self.debug, text, 3)

    def log_info(self, text):
        self.log_format(self.info, text, 4)

    def log_warn(self, text):
        self.log_format(self.warn, text, 4)

    def log_error(self, text):
        self.log_format(self.error, text, 3)

    def log_fatal(self, text):
        self.log_format(self.fatal, text, 3)

    def log_update(self, text):
        self.log_format(self.update, text, 2)

    def log_success(self, text):
        self.log_format(self.success, text, 1)
