#!/usr/bin/python3.10

import os

from man import InitClass as InitClass

from man.log import Log as Log
import man.helpers as helpers


log = Log()


class File(InitClass):
    def __init__(self, file_name, root_folder, type, specific_items_to_install):
        InitClass.__init__(self)

        self.root_folder = root_folder
        self.name = file_name
        self.type = type
        self.file_location = helpers.join(
            self.root_folder, self.type, self.name)
        self.file_destination = self.get_location()
        self.specific_items_to_install = specific_items_to_install

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
            open(self.file_destination, "x")
            log.log_info("Creating file {}".format(self.file_destination))
        except FileNotFoundError:
            os.makedirs(os.path.dirname(self.file_destination))
            log.log_info("Creating folder {}".format(self.file_destination))
        except FileExistsError:
            pass

        if len(self.specific_items_to_install) > 0:
            if os.path.basename(self.file_location) in self.specific_items_to_install:
                self.install()
            else:
                log.log_warn(
                    "Skipping the installation of {}".format(
                        os.path.basename(self.file_location),
                    )
                )
        else:
            self.install()

    def install(self):
        log.log_trace("Checking the hash for {}".format(self.file_location))
        if not self.check_sum():
            log.log_fatal("Returning")
            return
        if self.type != ".local":
            log.log_trace("Installing {}.".format(
                os.path.basename(self.file_location)))
            helpers.symlink(self.file_location, self.file_destination)
            log.log_trace(
                "Symlinking: {} -> {}".format(
                    self.file_location,
                    self.file_destination,
                )
            )
            log.log_info("Installed {}.".format(
                os.path.basename(self.file_location)))
        else:
            for file in os.listdir(self.file_location):
                file_location = helpers.join(self.file_location, file)
                file_destination = helpers.join(self.file_destination, file)
                helpers.symlink(file_location, file_destination)
                log.log_trace(
                    "Symlinking: {} -> {}".format(
                        file_location,
                        file_destination,
                    )
                )
            log.log_info("Installed {}.".format(
                os.path.basename(self.file_location)))

    def check_sum(self):
        return True

    def __repr__(self):
        return self.name


class Files(InitClass, dict):
    def __init__(self, aspect, specific_items_to_install):
        InitClass.__init__(self)

        self.root_folder = helpers.join(self.aspects_dir, aspect, "files")
        self.specific_items_to_install = specific_items_to_install

        config = helpers.join(self.root_folder, ".config")
        home = helpers.join(self.root_folder, ".home")
        local = helpers.join(self.root_folder, ".local")

        self.config = config if os.path.exists(config) else None
        self.home = home if os.path.exists(home) else None
        self.local = local if os.path.exists(local) else None

        self.files = self.root_folder

        self.files = self.root_folder
        self.aspect_json_file_location = helpers.join(
            self.aspects_dir, aspect, "aspect.json"
        )
        self.data = helpers.load_data(self.aspect_json_file_location)

        if not self.data:
            log.log_warn("Couldn't find [aspect.json] for " + self.aspect_name)

        log.log_trace("Installing all files for {}.".format(aspect.title()))

        dict.__init__(self, self.get_files())

        log.log_trace("Installed all files for {}.".format(aspect.title()))

    def get_files(self):
        files = {
            "home": {},
            "config": {},
            "local": {},
        }

        for type in self.types:
            for file in self.data["files"][type]:
                File(
                    file,
                    self.root_folder,
                    type,
                    self.specific_items_to_install,
                )

        return files
