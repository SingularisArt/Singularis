#!/usr/bin/python3.10

from pathlib import Path
import os
import re

from man import InitClass as InitClass

from man.log import Log as Log
import man.helpers as helpers

log = Log()


class Aspect(InitClass):
    def __init__(self, aspect_name, args):
        InitClass.__init__(self)

        self.specific_items_to_install = []

        try:
            search = re.search(r"(.+)\((.+)\)", aspect_name)
            aspect_name = search.group(1)
            self.specific_items_to_install = search.group(2).split(",")
        except Exception:
            pass

        self.aspect_name = aspect_name if aspect_name[0] != "^" else aspect_name[1:]
        self.install = True if aspect_name[0] != "^" else False
        self.args = args

    def install_aspect(self):
        code = Path(
            helpers.join(self.aspects_dir, self.aspect_name, "index.py", seperator="/")
        ).read_text()

        exec(
            code,
            {
                "specific_items_to_install": self.specific_items_to_install,
                "args": self.args,
            },
        )

    def __repr__(self):
        return self.aspect_name


class Aspects(InitClass, dict):
    def __init__(self, args):
        InitClass.__init__(self)

        self.args = args
        self.all = True
        self.aspects_to_install = []
        self.aspects_to_not_install = []
        self.all_aspects = [
            Aspect(a, self.args)
            for a in os.listdir(self.aspects_dir)
            if os.path.exists("{}/{}/index.py".format(self.aspects_dir, a))
        ]

        if self.args.aspect != " ":
            aspects = self.args.aspect.split(" ")
            aspects = [Aspect(aspect, self.args) for aspect in aspects]

            self.aspects_to_not_install = [
                aspect for aspect in aspects if not aspect.install
            ]
            self.aspects_to_install = [aspect for aspect in aspects if aspect.install]

            if (
                len(self.aspects_to_not_install) == 0
                and len(self.aspects_to_install) == 0
            ):
                self.aspects_to_install = self.all_aspects
            elif len(self.aspects_to_install) > 0:
                pass
            else:
                all_aspects = [aspect.aspect_name for aspect in self.all_aspects]
                dont_install = [
                    dont_install.aspect_name
                    for dont_install in self.aspects_to_not_install
                ]

                aspects_to_install = list(set(all_aspects) - set(dont_install))

                for dont_install_aspect in dont_install:
                    log.log_warn("Skipping installation of " + dont_install_aspect)

                self.aspects_to_install = [
                    Aspect(aspect) for aspect in aspects_to_install
                ]

        if not self.aspects_to_install and not self.aspects_to_not_install:
            self.aspects_to_install = self.all_aspects

        self.aspects_in_dictionary = {
            "all_aspects": self.all_aspects,
            "install_all": self.all,
            "aspects_to_install": self.aspects_to_install,
            "aspects_to_not_install": self.aspects_to_not_install,
        }

        dict.__init__(self, self.aspects_in_dictionary)
