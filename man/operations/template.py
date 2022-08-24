#!/usr/bin/python3.10

import os
import string

from man import InitClass as InitClass
import man.helpers as helpers


class CustomTemplate(string.Template):
    delimiter = "^"


class Template(InitClass):
    def __init__(self, file_name, root_folder, type, delimiter, data):
        InitClass.__init__(self)
        CustomTemplate.delimiter = delimiter

        self.root_folder = root_folder
        self.name = file_name
        self.type = type
        self.file_location = helpers.join(
            self.root_folder,
            self.type,
            self.name
        )
        self.file_destination = self.get_location()
        self.delimiter = delimiter
        self.data = data

        # TODO: Implement this function
        if self.check_sum():
            self.install()

    def get_location(self):
        if self.type == ".config":
            return helpers.join(self.config_dir, self.name)
        elif self.type == ".home":
            return helpers.join(self.home_dir, self.name)
        elif self.type == ".local":
            return helpers.join(self.local_dir, self.name)

    def install(self):
        try:
            open(self.file_destination, "x")
        except FileNotFoundError:
            os.makedirs(os.path.dirname(self.file_destination), exist_ok=True)
        except FileExistsError:
            pass

        opened_template = open(self.file_location, "r").read()
        opened_template = CustomTemplate(opened_template)

        variable_repacment = {}

        for snippet in self.data:
            file_template_location = helpers.join(
                self.man_dir,
                "templates",
                self.type,
                self.name,
                snippet + ".template"
            )
            opened_file_template_location = open(
                file_template_location,
                "r"
            ).read()

            variable_repacment[snippet] = opened_file_template_location

        completed_template = opened_template.safe_substitute(
            variable_repacment)

        with open(self.file_destination, "w") as writing_template:
            writing_template.write(completed_template)

    def check_sum(self):
        return True

    def __repr__(self):
        return self.name


class Templates(InitClass, dict):
    def __init__(self, aspect):
        InitClass.__init__(self)

        self.root_folder = helpers.join(
            self.aspects_dir,
            aspect,
            "templates"
        )

        config = helpers.join(self.root_folder, ".config")
        home = helpers.join(self.root_folder, ".home")
        local = helpers.join(self.root_folder, ".local")

        self.config = config if os.path.exists(config) else None
        self.home = home if os.path.exists(home) else None
        self.local = local if os.path.exists(local) else None

        self.templates = self.root_folder
        self.aspect_json_file_location = helpers.join(
            self.aspects_dir, aspect, "aspect.json"
        )
        self.data = helpers.load_data(self.aspect_json_file_location)

        dict.__init__(self, self.get_templates())

    def get_templates(self):
        templates = {
            "home": {},
            "config": {},
            "local": {},
        }

        types = [".home", ".config", ".local"]

        for type in types:
            for template in self.data["templates"][type]:
                Template(
                    template,
                    self.root_folder,
                    type,
                    "^",
                    self.data["templates"][type][template]
                )

        return templates
