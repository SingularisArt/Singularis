import os
from string import Template

import yaml

import man.helpers as helpers
from man.log import Log as Log
from man.variables import (aspects_dir, config_dir, home_dir, local_dir,
                           man_dir, types)


class NewStrTemp(Template):
    delimiter = "[-"
    pattern = r"""
    \^\{(?:
       (?P<escaped>-) |
       (?P<named>(.)+)\} |
       \b\B(?P<braced>) |
       (?P<invalid>)
    )
    """


log = Log()


class Template:
    def __init__(
        self,
        aspect,
        template_name,
        root_folder,
        type,
        delimiter,
        data,
        specific_items_to_install,
        specific_items_to_ignore,
        private,
    ):
        self.aspect = aspect
        self.aspect_dir = helpers.join(aspects_dir, aspect)
        self.root_folder = root_folder
        self.name = template_name
        self.aspect_name = os.path.dirname(self.name)
        self.type = type
        self.template_location = helpers.join(
            self.root_folder,
            self.type,
            self.name + ".temp",
        )
        self.template_destination = self.get_location()
        self.delimiter = delimiter
        self.data = data
        self.specific_items_to_install = specific_items_to_install
        self.specific_items_to_ignore = specific_items_to_ignore
        self.private = private

        # TODO: Implement this function
        destination = helpers.pretty_log(
            log,
            log.trace,
            self.template_destination,
        )

        log.log_trace(f"Checking the hash for {destination}.")

        if self.check_sum():
            self.setup_for_installation()

    def get_location(self):
        if self.type == ".config":
            return helpers.join(config_dir, self.name)
        elif self.type == ".home":
            return helpers.join(home_dir, self.name)
        elif self.type == ".local":
            return helpers.join(local_dir, self.name)

    def setup_for_installation(self):
        try:
            open(self.template_destination, "x")
            log.log_trace(f"Creating file {self.template_destination}")
        except FileNotFoundError:
            os.makedirs(os.path.dirname(self.template_destination))
            log.log_trace(f"Creating folder {self.template_destination}")
        except FileExistsError:
            log.log_trace(f"File {self.template_destination} already exists")

        if len(self.specific_items_to_install) > 0:
            if self.aspect_name in self.specific_items_to_install:
                self.install()
        else:
            self.install()

    def get_path_to_template_snippets(self, snippet):
        public_or_private = "private" if self.private else "public"
        file_ending = helpers.join(self.type, self.name, snippet + ".template")

        path = helpers.join(
            man_dir,
            "templates",
            public_or_private,
            file_ending,
        )

        if not os.path.exists(path) and public_or_private == "private":
            public_or_private = "private" if not self.private else "public"
            path = helpers.join(
                man_dir,
                "templates",
                public_or_private,
                file_ending,
            )

        return path

    def install(self):
        opened_template = open(self.template_location, "r").read()
        private_info = open(helpers.join(self.aspect_dir, "vars/private.yaml"))
        public_info = open(
            helpers.join(self.aspect_dir, "vars/public.yaml"),
        )

        opened_template = NewStrTemp(opened_template)
        replace_dict = {}

        if self.private:
            private_vars = yaml.load(private_info, Loader=yaml.FullLoader)
            for var in private_vars:
                try:
                    replace_dict[var] = private_vars[var]
                except KeyError:
                    replace_dict[var] = public_vars[var]
        else:
            public_vars = yaml.load(public_info, Loader=yaml.FullLoader)

            for var in public_vars:
                replace_dict[var] = public_vars[var]

        completed_template = opened_template.safe_substitute(replace_dict)

        name = helpers.pretty_log(log, log.trace, self.name)
        destination = helpers.pretty_log(
            log,
            log.trace,
            self.template_destination,
        )

        log.log_trace(f"Expanding template {name}.")

        with open(self.template_destination, "w") as writing_template:
            writing_template.write(completed_template)

        log.log_trace(f"Writing snippet {name} to {destination}.")

    def check_sum(self):
        return True

    def __repr__(self):
        return self.name


class Templates(dict):
    def __init__(
        self, aspect, specific_items_to_install, specific_items_to_ignore, args
    ):
        self.aspect = aspect
        self.root_folder = helpers.join(aspects_dir, aspect, "files")
        self.specific_items_to_install = specific_items_to_install
        self.specific_items_to_ignore = specific_items_to_ignore
        self.args = args

        config = helpers.join(self.root_folder, ".config")
        home = helpers.join(self.root_folder, ".home")
        local = helpers.join(self.root_folder, ".local")

        self.config = config if os.path.exists(config) else None
        self.home = home if os.path.exists(home) else None
        self.local = local if os.path.exists(local) else None

        self.templates = self.root_folder
        self.aspect_json_template_location = helpers.join(
            aspects_dir, aspect, "aspect.json"
        )
        self.data = helpers.load_data(
            self.aspect_json_template_location, self.aspect, log
        )

        log.log_trace(f"Installing all templates for {aspect.title()}")

        dict.__init__(self, self.get_templates())

        log.log_trace(f"Installed all templates for {aspect.title()}")

    def get_templates(self):
        templates = {
            "home": {},
            "config": {},
            "local": {},
        }

        private = True if self.args.singularis else False

        for type in types:
            try:
                for template in self.data["templates"][type]:
                    Template(
                        self.aspect,
                        template,
                        self.root_folder,
                        type,
                        "^",
                        self.data["templates"][type][template],
                        self.specific_items_to_install,
                        self.specific_items_to_ignore,
                        private,
                    )
            except KeyError:
                pass

        return templates
