#!/usr/bin/python3.10

from argparse import ArgumentParser
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
        personal: dict,
    ):
        """
        Initialize the File class.

        Args:
            file_name (str): The file name.
            root (str): The root directory.
            type (str): What type of aspect is it. ".home", ".config", ".local"
            specific_items_to_install (list): A list of all the specific
                to either install or avoid.
            personal (dict): Example:
                personal = {
                    "install_personal_aspect": False,
                    "running_personal_command": False,
                }

                This holds the information about the aspect, regarding if it's
                a personal or public aspect as well as if the user is using
                the --singularis option.
        """

        # The root location of the aspect
        self.root = root
        # The name of the aspect
        self.name = file_name
        # What type is the aspect: .config, .home, .local
        # This helps when determining where to install it to
        self.type = type
        # Where the file is located
        self.file_location = helpers.join(self.root, self.type, self.name)
        # Where to install the file to
        self.file_destination = self.get_location()
        # A list of specfic sub-aspects that the user would like to install.
        # For example, I may run `./install --aspect "dotfiles(neomutt)"`. The
        # specific_items_to_install = ["neomutt"], which means I only install
        # neomutt. Samething the other way around. The user may run `./install
        # --aspect "dotfiles(^neomutt)"`, which means install everything except
        # neomutt.
        self.specific_items_to_install = specific_items_to_install
        # This is a dictionary of a bunch of booleans to help keep track of the
        # private and public aspects. If the user uses the `--singularis`
        # option, then that'll install everything, including the aspects that
        # are option as personal. But if the user doesn't use that option, then
        # the installation of the aspects that are marked as personal won't be
        # installed, and the user will be notified by a log_warn level.
        self.personal = personal

        # Setup the installation for the aspect.
        self.setup_for_installation()

    def get_location(self):
        """
        Get the location for the aspect. If the:
            self.type == ".config", then the installation directory will be
                ~/.config/
            self.type == ".home", then the installation directory will be
                ~/
            self.type == ".local", then the installation directory will be
                ~/.local/

        Returns:
            str: The base of the installation path.
        """

        if self.type == ".config":
            return helpers.join(config_dir, self.name)
        elif self.type == ".home":
            return helpers.join(home_dir, self.name)
        elif self.type == ".local":
            return helpers.join(local_dir, self.name)

    def setup_for_installation(self):
        """
        Get the installation for the aspect ready, such as check if the aspect
        is what the user wants to install based on the optional
        specific_items_to_install variable. Also to create any folders or files
        that are necessary for the installation of the aspect.
        """

        # Create a file, if needed.
        try:
            open(self.file_destination, "x")
            log.log_info(f"Creating file {self.file_destination}")
        # Create a folder, if needed.
        except FileNotFoundError:
            os.makedirs(os.path.dirname(self.file_destination))
            log.log_info(f"Creating folder {self.file_destination}")
        # If the file and or folder exists, just continue.
        except FileExistsError:
            pass

        # Check if the user didn't specify to install any specific aspects.
        # If not, just go ahead and install it.
        if len(self.specific_items_to_install) == 0:
            self.install()
            return

        # If the user did, check if the current aspect is one of them.
        specific_items_to_install = self.specific_items_to_install
        if os.path.basename(self.file_location) in specific_items_to_install:
            # If so, go ahead and install
            self.install()
        else:
            # Otherwise, log a warning to the user to notify them that the
            # current aspect won't be installed.
            name = helpers.pretty_log(
                log, log.warn, os.path.basename(self.file_location)
            )
            log.log_warn(f"Skipping the installation of {name}")

    def install(self):
        """
        Install the given aspect.

        If the aspect is marked as personal, and the user doesn't use the
        --singularis option, the instalation of the given aspect will be
        halted, and a log of the level warning will be output for the user to
        see.
        """

        # Check if the aspect is personal or not.
        is_aspect_personal = self.personal["install_personal_aspect"]
        # Check if the user is using the --singularis option or not.
        is_personal_command_running = self.personal["running_personal_command"]

        # If the aspect is personal and the user isn't using the --singularis
        # option, then the installation will be halted, and a warning will be
        # displayed to the user.
        if is_aspect_personal and not is_personal_command_running:
            name = helpers.pretty_log(log, log.warn, self.name)
            cmd = helpers.pretty_log(log, log.warn, "--singularis")

            log.log_warn(
                f"You need to be using the {cmd} command to "
                + f"install the {name} aspect."
            )
            return

        # Log that we're checking the hash of the aspect.
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

        # If the aspect installation type isn't .local, since those aspects
        # require a different type of installation, which I'll explain later
        # down.
        if self.type != ".local":
            name = os.path.basename(self.file_location)
            # Log that we're installing the aspect.
            log.log_trace(f"Installing {name}.")
            # Symlink the aspect from it's location to it's destination.
            helpers.symlink(self.file_location, self.file_destination)
            # Log that.
            log.log_trace(
                f"Symlinking: {self.file_location} -> {self.file_destination}"
            )
            # Finally, log that we've completed the installation.
            log.log_info(f"Installed {name}.")

            return

        # If the installation type is .local, then we need to iterate
        # through each file inside the aspect. Let me explain:
        # When we have the aspect .local/bin, then if we symlink the entire
        # folder, we'll overwrite all the user's custom executables, which
        # is why we need to symlink each indavidual file within the aspect
        # to it's own destination to avoid this issue.
        for file in os.listdir(self.file_location):
            # Get the new file location.
            file_location = helpers.join(self.file_location, file)
            # Get the new file destination.
            file_destination = helpers.join(self.file_destination, file)
            # Symlink the aspect from it's location to it's destination.
            helpers.symlink(file_location, file_destination)
            # Symlink the aspect from it's location to it's destination.
            helpers.symlink(file_location, file_destination)
            # Log that.
            log.log_trace(f"Symlinking: {file_location} -> {file_destination}")

        name = os.path.basename(self.file_location)
        # Log that we've installed the aspect.
        log.log_info(f"Installed {name}.")

    def check_sum(self):
        """
        Check the sum of the aspect.

        Returns:
            bool: If the sum is correct, then True.
            bool: If the sum is in correct, then False.
        """

        return True


class Files:
    def __init__(
        self,
        aspect: str,
        specific_items_to_install: list,
        args: ArgumentParser.parse_args,
    ):
        """
        Initialize the File class.

        Args:
            aspect (str): The aspect name.
            specific_items_to_install (list): A list of all the specific
                to either install or avoid.
            args (ArgumentParser.parse_args): The arguments from argparse.
        """

        self.args = args
        # Create the root directory of the aspect.
        self.root = helpers.join(aspects_dir, aspect, "files")
        # Get any
        # A list of specfic sub-aspects that the user would like to install.
        # For example, I may run `./install --aspect "dotfiles(neomutt)"`. The
        # specific_items_to_install = ["neomutt"], which means I only install
        # neomutt. Samething the other way around. The user may run `./install
        # --aspect "dotfiles(^neomutt)"`, which means install everything except
        # neomutt.
        self.specific_items_to_install = specific_items_to_install

        # Create the directories to each of the 3 types of aspects.
        config = helpers.join(self.root, ".config")
        home = helpers.join(self.root, ".home")
        local = helpers.join(self.root, ".local")

        # Create variables if each directory exists.
        self.config = config if os.path.exists(config) else None
        self.home = home if os.path.exists(home) else None
        self.local = local if os.path.exists(local) else None

        # Get the location of the aspect.json within the aspect.
        self.aspect_json_file_location = helpers.join(
            aspects_dir, aspect, "aspect.json"
        )
        # Load that data in.
        self.data = helpers.load_data(self.aspect_json_file_location)

        # If the aspect.json file doesn't exist, then create a fatal error and
        # exit.
        if not os.path.exists(self.aspect_json_file_location):
            aspect_json = helpers.pretty_log(log, log.fatal, "aspect.json")
            name = helpers.pretty_log(log, log.fatal, aspect)
            log.log_fatal(f"Couldn't find {aspect_json} for {name}. Quitting.")

            return

        # Log that we're installing all the files within the aspect.
        log.log_trace(f"Installing all files for {aspect.title()}.")

        # Install all the files within the aspect. I'm doing this by creating
        # an object class for each file. For example, the neomutt file within
        # the dotfiles will be it's own class. Then, it installs itself.
        self.get_files()

        # Log that we've finished installing if everything succeeded.
        log.log_trace(f"Installed all files for {aspect.title()}.")

    def get_files(self):
        """ Install the files within the aspect. """

        # This variable will store all the information that's required for
        # keeping track about if the aspect is a public or personal one.
        # It also keeps track if the user uses the --singularis option, which
        # makes the progarm install all aspects that are personal, which means
        # if you aren't SingularisArt, then don't use the frecking option.
        personal = {
            "install_personal_aspect": False,
            "running_personal_command": False,
        }

        # Iterate through the different types of aspects.
        for current_type in types:
            # Iterate through all the files within the current type.
            for file in self.data["files"][current_type]:
                personal_aspect = self.data["files"][current_type][file]
                # Set to True of the aspect is a personal aspect. Else, False.
                personal["install_personal_aspect"] = (
                    True if personal_aspect == "personal" else False
                )
                # Set to True of the user uses the --singularis option. Else,
                # False.
                personal["running_personal_command"] = (
                    True if self.args.singularis else False
                )

                # Install the aspect using the File class, which is a class for
                # each individual file.
                File(
                    file,
                    self.root,
                    current_type,
                    self.specific_items_to_install,
                    personal,
                )
