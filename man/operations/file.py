import os

import man.helpers as helpers
from man.log import Log as Log
from man.variables import aspects_dir, config_dir, home_dir, local_dir, types

log = Log()


class File:
    def __init__(
        self,
        file_name,
        root,
        type,
        specific_items_to_install,
        specific_items_to_ignore,
        private,
        args,
    ):
        self.args = args
        self.root = root
        self.name = file_name
        self.type = type
        self.file_location = helpers.join(self.root, self.type, self.name)
        self.file_destination = self.get_location()
        self.specific_items_to_install = specific_items_to_install
        self.specific_items_to_ignore = specific_items_to_ignore
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
        specific_items_to_install = self.specific_items_to_install

        try:
            open(self.file_destination, "x")
            log.log_info(f"Creating file {self.file_destination}.")
        except FileNotFoundError:
            os.makedirs(os.path.dirname(self.file_destination))
            log.log_info(f"Creating folder {self.file_destination}.")
        except FileExistsError:
            pass

        if len(specific_items_to_install) == 0:
            self.install()
            return

        if os.path.basename(self.file_location) in specific_items_to_install:
            self.install()
        else:
            name = helpers.pretty_log(
                log, log.warn, os.path.basename(self.file_location)
            )
            log.log_warn(f"Skipping the installation of {name}.")

    def install(self):
        is_aspect_private = self.private["install_private_aspect"]
        is_private_command_running = self.private["running_private_command"]

        if is_aspect_private and not is_private_command_running:
            name = helpers.pretty_log(log, log.warn, self.name)
            cmd = helpers.pretty_log(log, log.warn, "--singularis")

            log.log_warn(
                f"You need to be using the {cmd} command to "
                + f"install the {name} aspect."
            )
            return

        log.log_trace(f"Checking the hash for {self.file_location}.")

        if not self.check_sum() and not self.args.no_security:
            name = helpers.pretty_log(log, log.error, self.name)
            cmd = helpers.pretty_log(log, log.error, "--no-security")
            log.log_fatal(
                f"Sum of {name} isn't matching up. Qutting for security "
                + f"purposes. If you want to install it, use the {cmd} option."
            )
            return

        name = os.path.basename(self.file_location)
        pretty_name = helpers.pretty_log(log, log.info, name)
        if name in self.specific_items_to_ignore:
            log.log_warn(f"Skipping the installation of {name}.")
            return

        if self.args.dry_run:
            log.log_info(f"Would have installed '{pretty_name}'.")
            return

        if self.args.confirm:
            if not helpers.confirm(f"Would you like to install the config files for '{pretty_name}'"):
                return

        if self.type != ".local":
            log.log_trace(f"Installing {pretty_name}.")
            helpers.symlink(self.file_location, self.file_destination)
            log.log_trace(
                f"Symlinking: {self.file_location} -> {self.file_destination}."
            )
            log.log_info(f"Installed {pretty_name}.")

            return

        for file in os.listdir(self.file_location):
            file_location = helpers.join(self.file_location, file)
            file_destination = helpers.join(self.file_destination, file)
            helpers.symlink(file_location, file_destination)
            helpers.symlink(file_location, file_destination)
            log.log_trace(f"Symlinking: {file_location} -> {file_destination}.")

        log.log_info(f"Installed {pretty_name}.")

    def check_sum(self):
        return True


class Files:
    def __init__(
        self,
        aspect_name,
        specific_items_to_install,
        specific_items_to_ignore,
        args,
    ):
        self.args = args
        self.root = helpers.join(aspects_dir, aspect_name, "files")
        self.specific_items_to_install = specific_items_to_install
        self.specific_items_to_ignore = specific_items_to_ignore

        config = helpers.join(self.root, ".config")
        home = helpers.join(self.root, ".home")
        local = helpers.join(self.root, ".local")

        self.config = config if os.path.exists(config) else None
        self.home = home if os.path.exists(home) else None
        self.local = local if os.path.exists(local) else None

        self.aspect_json_file_location = helpers.join(
            aspects_dir, aspect_name, "aspect.json"
        )
        self.data = helpers.load_data(self.aspect_json_file_location, aspect_name, log)

        log.log_trace(f"Installing all files for {aspect_name.title()}.")

        self.get_files()

        log.log_trace(f"Installed all files for {aspect_name.title()}.")

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
                        self.specific_items_to_ignore,
                        private,
                        self.args,
                    )
            except KeyError:
                pass
