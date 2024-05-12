import subprocess

import man.helpers as helpers
from man import InitClass as InitClass
from man.log import Log as Log
from man.variables import aspects_dir

log = Log()


class Library(InitClass, list):
    def __init__(
        self,
        aspect_name,
        specific_items_to_install,
        specific_items_to_ignore,
        args,
        library_type,
    ):
        InitClass.__init__(self)

        self.aspect_name = aspect_name
        self.specific_items_to_install = specific_items_to_install
        self.specific_items_to_ignore = specific_items_to_ignore
        self.args = args
        self.library_type = library_type

        if self.library_type == "python" and self.args.no_python or self.library_type == "node" and self.args.no_node:
            log.log_warn(f"Skipping installing {self.library_type} libraries for {self.aspect_name}.")
            return

        self.aspect_json_file_location = helpers.join(
            aspects_dir, self.aspect_name, "aspect.json",
        )

        self.data = helpers.load_data(self.aspect_json_file_location, aspect_name, log)
        self.libraries = {}

        try:
            self.libraries = self.data["libraries"][self.library_type]
        except KeyError:
            log.log_warn(f"No {self.library_type} libraries to install for {self.aspect_name}.")
            return

        log.log_trace(f"Installing all {self.library_type} libraries for {self.aspect_name.title()}.")
        self.get_libraries()
        log.log_trace(f"Installed all {self.library_type} libraries for {self.aspect_name.title()}.")

    def get_libraries(self):
        for lib in self.libraries:
            if not self.specific_items_to_install and not self.specific_items_to_ignore:
                self.install_library(lib)

            elif lib in self.specific_items_to_install:
                self.install_library(lib)

    def install_library(self, lib):
        log.log_trace(f"Installing {lib} for {self.aspect_name.title()}.")
        cmd = [
            "pip3",
            "install",
        ]
        if self.library_type == "node":
            cmd = [
                "sudo",
                "npm",
                "install",
                "-g",
            ]
        for library in self.libraries[lib]:
            cmd_lib = cmd.copy()
            cmd_lib.append(library)

            log.log_trace(f"Installing {library} for {self.aspect_name.title()}.")
            log_level = int(self.args.log_level)
            try:
                log.log_trace(f"Installing {self.library_type} library '{library}' for {self.aspect_name.title()}.")
                stdout = subprocess.PIPE if log_level > 2 or log_level == -1 else None
                stderr = subprocess.PIPE if log_level > 2 or log_level == -1 else None
                subprocess.run(
                    cmd_lib,
                    stdout=stdout,
                    stderr=stderr,
                    check=True,
                )
                log.log_info(f"Installed {self.library_type} library '{library}' for {self.aspect_name.title()}.")
            except subprocess.CalledProcessError as e:
                log.log_error(f"Error installing {self.library_type} library {library} for {self.aspect_name.title()}.")
                if log_level <= 2 and log_level != -1:
                    log.log_debug(e.stderr.decode("utf-8"))



class Python(Library):
    def __init__(self, aspect_name, specific_items_to_install, specific_items_to_ignore, args):
        Library.__init__(
            self,
            aspect_name,
            specific_items_to_install,
            specific_items_to_ignore,
            args,
            "python",
        )


class Node(Library):
    def __init__(self, aspect_name, specific_items_to_install, specific_items_to_ignore, args):
        Library.__init__(
            self,
            aspect_name,
            specific_items_to_install,
            specific_items_to_ignore,
            args,
            "node",
        )
