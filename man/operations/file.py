#!/usr/bin/python3.10

import os

from man import InitClass as InitClass

from man.log import Log as Log
import man.helpers as helpers


log = Log()


class File(InitClass):
    def __init__(self, file_name, root_folder, type):
        InitClass.__init__(self)

        self.root_folder = root_folder
        self.name = file_name
        self.type = type
        self.file_location = helpers.join(
            self.root_folder, self.type, self.name)
        self.file_destination = self.get_location()

        # TODO: Implement this function
        log.log_trace("Checking the hash for {}".format(self.file_location))

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
            log.log_trace("Creating file {}".format(self.file_destination))
        except FileNotFoundError:
            os.makedirs(os.path.dirname(self.file_destination))
            log.log_trace("Creating folder {}".format(self.file_destination))
        except FileExistsError:
            pass

        if self.type != ".local":
            log.log_trace(
                "Symlinking: {} -> {}".format(
                    self.file_location,
                    self.file_destination,
                )
            )
            helpers.symlink(self.file_location, self.file_destination)
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

    def check_sum(self):
        return True

    def __repr__(self):
        return self.name


class Files(InitClass, dict):
    def __init__(self, aspect):
        InitClass.__init__(self)

        self.root_folder = helpers.join(self.aspects_dir, aspect, "files")

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

        log.log_trace("Installing all files for {}".format(aspect.title()))

        dict.__init__(self, self.get_files())

        log.log_trace("Installed all files for {}".format(aspect.title()))

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
                )

        return files
