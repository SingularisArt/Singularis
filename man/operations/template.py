#!/usr/bin/python3.10

import os
import string

from man import InitClass as InitClass

from man.log import Log as Log
import man.helpers as helpers


log = Log()


class CustomTemplate(string.Template):
    delimiter = "^"


class Template(InitClass):
    def __init__(
        self,
        template_name,
        root_folder,
        type,
        delimiter,
        data,
        specific_items_to_install,
        personal=False,
    ):
        InitClass.__init__(self)
        CustomTemplate.delimiter = delimiter
        log.log_trace("Chaning delimiter from # to {}".format(delimiter))

        self.root_folder = root_folder
        self.name = template_name
        self.type = type
        self.template_location = helpers.join(
            self.root_folder, self.type, self.name)
        self.template_destination = self.get_location()
        self.delimiter = delimiter
        self.data = data
        self.personal = personal
        self.specific_items_to_install = specific_items_to_install

        # TODO: Implement this function
        log.log_trace("Checking the hash for {}".format(
            self.template_location))

        if self.check_sum():
            self.setup_for_installation()

    def get_location(self):
        if self.type == ".config":
            return helpers.join(self.config_dir, self.name)
        elif self.type == ".home":
            return helpers.join(self.home_dir, self.name)
        elif self.type == ".local":
            return helpers.join(self.local_dir, self.name)

    def setup_for_installation(self):
        try:
            open(self.template_destination, "x")
            log.log_trace("Creating file {}".format(self.template_destination))
        except FileNotFoundError:
            os.makedirs(os.path.dirname(self.template_destination))
            log.log_trace("Creating folder {}".format(
                self.template_destination))
        except FileExistsError:
            log.log_trace("File {} already exists".format(
                self.template_destination))

        if len(self.specific_items_to_install) > 0:
            if (
                os.path.basename(self.template_location)
                in self.specific_items_to_install
            ):
                self.install()
            else:
                log.log_warn(
                    "Skipping the installation of {}".format(
                        os.path.basename(self.template_location),
                    )
                )
        else:
            self.install()

    def get_path_to_template_expanding_snippets(self, snippet):
        public_or_personal = "personal" if self.personal else "public"
        file_ending = helpers.join(self.type, self.name, snippet + ".template")

        path = helpers.join(self.man_dir, "templates",
                            public_or_personal, file_ending)

        if not os.path.exists(path) and public_or_personal == "personal":
            public_or_personal = "personal" if not self.personal else "public"
            path = helpers.join(
                self.man_dir, "templates", public_or_personal, file_ending
            )

        return path

    def install(self):
        opened_template = open(self.template_location, "r").read()
        opened_template = CustomTemplate(opened_template)

        variable_repacment = {}

        for snippet in self.data:
            template_location = self.get_path_to_template_expanding_snippets(
                snippet)
            opened_template_location = open(template_location, "r").read()

            variable_repacment[snippet] = opened_template_location

        completed_template = opened_template.safe_substitute(
            variable_repacment)

        log.log_trace("Expanding template {}".format(self.name))

        with open(self.template_destination, "w") as writing_template:
            writing_template.write(completed_template)

        log.log_trace(
            "Writing snippet {} to {}".format(
                self.name, self.template_destination)
        )

    def check_sum(self):
        return True

    def __repr__(self):
        return self.name


class Templates(InitClass, dict):
    def __init__(self, aspect, specific_items_to_install, args):
        InitClass.__init__(self)

        self.root_folder = helpers.join(self.aspects_dir, aspect, "templates")
        self.specific_items_to_install = specific_items_to_install
        self.args = args

        config = helpers.join(self.root_folder, ".config")
        home = helpers.join(self.root_folder, ".home")
        local = helpers.join(self.root_folder, ".local")

        self.config = config if os.path.exists(config) else None
        self.home = home if os.path.exists(home) else None
        self.local = local if os.path.exists(local) else None

        self.templates = self.root_folder
        self.aspect_json_template_location = helpers.join(
            self.aspects_dir, aspect, "aspect.json"
        )
        self.data = helpers.load_data(self.aspect_json_template_location)

        if not self.data:
            log.log_warn("Couldn't find [aspect.json] for " + self.aspect_name)

        log.log_trace("Installing all templates for {}".format(aspect.title()))

        dict.__init__(self, self.get_templates())

        log.log_trace("Installed all templates for {}".format(aspect.title()))

    def get_templates(self):
        templates = {
            "home": {},
            "config": {},
            "local": {},
        }

        types = [".home", ".config", ".local"]
        personal = True if self.args.singularis else False

        for type in types:
            for template in self.data["templates"][type]:
                Template(
                    template,
                    self.root_folder,
                    type,
                    "^",
                    self.data["templates"][type][template],
                    self.specific_items_to_install,
                    personal,
                )

        return templates
