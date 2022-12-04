#!/usr/bin/python3.10

import os

from man.variables import (
    aspects_dir,
    types,
    home_dir,
    config_dir,
    local_dir,
)
from man.log import Log as Log
import man.helpers as helpers


log = Log()


class File:
    def __init__(
        self,
        file_name: str,
        root: str,
        type: str,
        specific_items_to_install: list,
        private: dict,
    ):
        self.root = root
        self.name = file_name
        self.type = type
        self.file_location = helpers.join(self.root, self.type, self.name)
        self.file_destination = self.get_location()
        self.specific_items_to_install = specific_items_to_install
        self.private = private

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
            open(self.file_destination, "x")
            log.log_info(f"Creating file {self.file_destination}")
        except FileNotFoundError:
            os.makedirs(os.path.dirname(self.file_destination))
            log.log_info(f"Creating folder {self.file_destination}")
        except FileExistsError:
            pass

        if len(self.specific_items_to_install) == 0:
            self.install()
            return

        specific_items_to_install = self.specific_items_to_install
        if os.path.basename(self.file_location) in specific_items_to_install:
            self.install()
        else:
            name = helpers.pretty_log(
                log, log.warn, os.path.basename(self.file_location)
            )
            log.log_warn(f"Skipping the installation of {name}")

    def install(self):
        is_aspect_private = self.private["install_private_aspect"]
        is_private_command_running = self.private["running_private_command"]

        # displayed to the user.
        if is_aspect_private and not is_private_command_running:
            name = helpers.pretty_log(log, log.warn, self.name)
            cmd = helpers.pretty_log(log, log.warn, "--singularis")

            log.log_warn(
                f"You need to be using the {cmd} command to "
                + f"install the {name} aspect."
            )
            return

        log.log_trace(f"Checking the hash for {self.file_location}")

        # If the sum isn't correct.
        if not self.check_sum():
            name = helpers.pretty_log(log, log.error, self.name)
            cmd = helpers.pretty_log(log, log.error, "--no-security")
            log.log_fatal(
                f"Sum of {name} isn't matching up. Qutting for security "
                + f"purpises. If you want to install it, use the {cmd} option."
            )
            return

        if self.type != ".local":
            name = os.path.basename(self.file_location)
            log.log_trace(f"Installing {name}.")
            helpers.symlink(self.file_location, self.file_destination)
            log.log_trace(
                f"Symlinking: {self.file_location} -> {self.file_destination}"
            )
            log.log_info(f"Installed {name}.")

            return

        for file in os.listdir(self.file_location):
            file_location = helpers.join(self.file_location, file)
            file_destination = helpers.join(self.file_destination, file)
            helpers.symlink(file_location, file_destination)
            helpers.symlink(file_location, file_destination)
            log.log_trace(f"Symlinking: {file_location} -> {file_destination}")

        name = os.path.basename(self.file_location)
        log.log_info(f"Installed {name}.")

    def check_sum(self):
        return True


class Files:
    def __init__(
        self,
        aspect,
        specific_items_to_install,
        args,
    ):
        self.args = args
        self.root = helpers.join(aspects_dir, aspect, "files")
        self.specific_items_to_install = specific_items_to_install

        config = helpers.join(self.root, ".config")
        home = helpers.join(self.root, ".home")
        local = helpers.join(self.root, ".local")

        self.config = config if os.path.exists(config) else None
        self.home = home if os.path.exists(home) else None
        self.local = local if os.path.exists(local) else None

        self.aspect_json_file_location = helpers.join(
            aspects_dir, aspect, "aspect.json"
        )
        self.data = helpers.load_data(self.aspect_json_file_location)

        if not os.path.exists(self.aspect_json_file_location):
            aspect_json = helpers.pretty_log(log, log.fatal, "aspect.json")
            name = helpers.pretty_log(log, log.fatal, aspect)
            log.log_fatal(f"Couldn't find {aspect_json} for {name}. Quitting.")

            return

        log.log_trace(f"Installing all files for {aspect.title()}.")

        self.get_files()

        log.log_trace(f"Installed all files for {aspect.title()}.")

    def get_files(self):
        private = {
            "install_private_aspect": False,
            "running_private_command": False,
        }

        for current_type in types:
            try:
                for file in self.data["files"][current_type]:
                    private_aspect = self.data["files"][current_type][file]
                    private["install_private_aspect"] = (
                        True if private_aspect == "private" else False
                    )
                    private["running_private_command"] = (
                        True if self.args.singularis else False
                    )

                    File(
                        file,
                        self.root,
                        current_type,
                        self.specific_items_to_install,
                        private,
                    )
            except KeyError:
                pass
