#!/usr/bin/python3.10

from pathlib import Path
import os

from man import InitClass as InitClass
import man.helpers as helpers


class Aspect(InitClass):
    def __init__(self, aspect_name):
        InitClass.__init__(self)

        self.aspect_name = aspect_name \
            if aspect_name[0] != '^' \
            else aspect_name[1:]
        self.install = True if aspect_name[0] != '^' else False
        self.data = self.get_data()

    def __repr__(self):
        return self.aspect_name

    def get_data(self):
        json_file = helpers.join(
            self.aspects_dir,
            self.aspect_name,
            "aspect.json",
            seperator="/")

        if os.path.exists(json_file):
            data = helpers.load_data(json_file)
            return data
        else:
            print(json_file, "doesn't exist")

    def install_aspect(self):
        exec(Path(helpers.join(
            self.aspects_dir,
            self.aspect_name,
            "index.py",
            seperator="/")).read_text())


class Aspects(InitClass, list):
    def __init__(self, args):
        InitClass.__init__(self)

        self.args = args
        self.aspects = []

        if self.args.config != " ":
            aspects = self.args.config.split(" ")
            aspects = [*set(aspects)]

            for aspect in aspects:
                print(aspect)
                self.aspects.append(Aspect(aspect))

            self.install_aspects = [
                aspect for aspect in self.aspects if aspect.install
            ]
            self.not_install_aspects = [
                aspect for aspect in self.aspects if not aspect.install
            ]
            self.all = True if len(self.install_aspects) == 0 else False
        else:
            self.all = True
            self.aspects = []

        list.__init__(self, self.aspects)
