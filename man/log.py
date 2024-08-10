import os

from man import InitClass as InitClass
from man.colors import Colors as Colors


class Log(Colors, InitClass):
    def __init__(self):
        Colors.__init__(self)
        InitClass.__init__(self)

        self.off = {
            "name": "Off",
            "level": -1,
            "bg": self.bg["cyan"],
            "fg": self.fg["black"],
        }

        self.all = {
            "name": "All",
            "level": 0,
            "bg": "",
            "fg": self.fg["cyan"],
            "style": self.style["bold"],
        }

        self.trace = {
            "name": "[Trace]",
            "level": 1,
            "bg": "",
            "fg": self.fg["cyan"],
            "style": self.style["bold"],
        }

        self.debug = {
            "name": "[Debug]",
            "level": 2,
            "bg": "",
            "fg": self.fg["purple"],
            "style": self.style["bold"],
        }

        self.info = {
            "name": "[Info]",
            "level": 3,
            "bg": "",
            "fg": self.fg["white"],
            "style": self.style["bold"],
        }

        self.notice = {
            "name": "[Notice]",
            "level": 4,
            "bg": "",
            "fg": self.fg["yellow"],
            "style": self.style["bold"],
        }

        self.warn = {
            "name": "[Warn]",
            "level": 5,
            "bg": "",
            "fg": self.fg["orange"],
            "style": self.style["bold"],
        }

        self.error = {
            "name": "[Error]",
            "level": 6,
            "bg": "",
            "fg": self.fg["red"],
            "style": self.style["bold"],
        }

        self.fatal = {
            "name": "[Fatal]",
            "level": 7,
            "bg": "",
            "fg": self.fg["red"],
            "style": self.style["bold"],
        }

        self.success = {
            "name": "[Success]",
            "level": 8,
            "bg": "",
            "fg": self.fg["green"],
            "style": self.style["bold"],
        }

        if os.path.exists(self.log_level_txt):
            self.LOG_LEVEL = int(open(self.log_level_txt).read())
        else:
            self.LOG_LEVEL = int(self.info["level"])

    def log_format(self, type, text, spacing_number):
        if int(type["level"]) >= self.LOG_LEVEL and int(self.LOG_LEVEL) >= 0:
            spacing = " " * spacing_number

            print(
                "{}{}{}{}{}{} {}".format(
                    type["bg"],
                    type["fg"],
                    type["style"],
                    type["name"],
                    spacing,
                    self.style["reset"],
                    text,
                ),
            )

    def log_trace(self, text):
        self.log_format(self.trace, text, 3)

    def log_debug(self, text):
        self.log_format(self.debug, text, 3)

    def log_info(self, text):
        self.log_format(self.info, text, 4)

    def log_notice(self, text):
        self.log_format(self.notice, text, 2)

    def log_warn(self, text):
        self.log_format(self.warn, text, 4)

    def log_error(self, text):
        self.log_format(self.error, text, 3)

    def log_fatal(self, text):
        self.log_format(self.fatal, text, 3)

    def log_success(self, text):
        self.log_format(self.success, text, 1)
