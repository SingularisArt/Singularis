import os
from pathlib import Path

import man.helpers as helpers
from man import InitClass as InitClass
from man.log import Log as Log

log = Log()


class Aspect(InitClass):
    def __init__(self, aspect_name, args):
        InitClass.__init__(self)

        self.specific_items_to_install = []
        self.specific_items_to_ignore = []
        self.install = True
        self.args = args
        (
            self.aspect_name,
            self.specific_items_to_install,
            self.specific_items_to_ignore,
        ) = helpers.get_specific_items_to_install_and_ignore(aspect_name)

    def install_aspect(self):
        if not self.install:
            return

        pretty_name = helpers.pretty_log(log, log.info, self.aspect_name)

        if self.args.confirm:
            if not helpers.confirm(
                f"Would you like to install the aspect {pretty_name}"
            ):
                return

        file_path = helpers.join(
            self.aspects_dir, self.aspect_name, "index.py", seperator="/"
        )
        if not os.path.exists(file_path):
            log.log_error(
                "Couldn't find any aspect with the name of "
                + f"{self.aspect_name}. Please run the command "
                + "`./install --list-aspects` to view all possible options.",
            )
            return

        code = Path(file_path).read_text()
        replace_vars = {
            "specific_items_to_install": self.specific_items_to_install,
            "specific_items_to_ignore": self.specific_items_to_ignore,
            "args": self.args,
        }
        exec(code, replace_vars)

    def __repr__(self):
        return self.aspect_name


class Aspects(InitClass, dict):
    def __init__(self, args):
        InitClass.__init__(self)

        self.args = args
        self.aspects_to_install = []
        self.aspects_to_ignore = []
        self.all_aspects = [
            Aspect(a, self.args)
            for a in os.listdir(self.aspects_dir)
            if os.path.exists(f"{self.aspects_dir}/{a}/index.py")
        ]
        self.all_aspect_names = [
            a
            for a in os.listdir(self.aspects_dir)
            if os.path.exists(f"{self.aspects_dir}/{a}/index.py")
        ]

        s = self.args.aspect
        if not s or s == " ":
            self.aspects_to_install = self.all_aspects
            self.aspects_in_dictionary = {
                "all_aspects": self.all_aspects,
                "aspects_to_install": self.all_aspects,
                "aspects_to_not_install": [],
            }

            dict.__init__(self, self.aspects_in_dictionary)

            return
        elif s[0] == "^" and s[1] == "(" and s[-1] == ")":
            self.aspects_to_ignore = s[2:-1].split()
        elif s[0] == "^":
            self.aspects_to_ignore = s[1:].split()
        else:
            self.aspects_to_install = s.split()

        if len(self.aspects_to_ignore) > 0:
            self.aspects_to_install = [
                x for x in self.all_aspect_names if x not in self.aspects_to_ignore
            ]

        self.aspects_to_install = [
            Aspect(x, self.args) for x in self.aspects_to_install
        ]
        self.aspects_to_ignore = [
            Aspect(
                x,
                self.args,
            )
            for x in self.aspects_to_ignore
        ]

        self.aspects_in_dictionary = {
            "all_aspects": self.all_aspects,
            "aspects_to_install": self.aspects_to_install,
            "aspects_to_not_install": self.aspects_to_ignore,
        }

        dict.__init__(self, self.aspects_in_dictionary)
