import subprocess

import man.helpers as helpers
from man import InitClass as InitClass
from man.helpers import install_package
from man.loading_animation import Loader
from man.log import Log as Log
from man.variables import aspects_dir

log = Log()


class Packages(InitClass, list):
    def __init__(
        self,
        aspect_name,
        specific_items_to_install,
        specific_items_to_ignore,
        args,
    ):
        if args.no_packages:
            log.log_warn(
                f"Skipping package installation for the aspect {aspect_name}.",
            )
            return

        InitClass.__init__(self)

        self.aspect_name = aspect_name
        self.specific_items_to_install = specific_items_to_install
        self.specific_items_to_ignore = specific_items_to_ignore
        self.args = args

        self.aspect_json_file_location = helpers.join(
            aspects_dir, self.aspect_name, "aspect.json"
        )
        self.data = helpers.load_data(
            self.aspect_json_file_location, self.aspect_name, log
        )

        self.package_type = args.package_type

        if not self.data:
            return

        try:
            packages = self.data["packages"]
            for repo_type in packages:
                if repo_type != self.package_type:
                    continue

                package_type = packages[repo_type]
                for aspect_name in package_type:
                    if (
                        not self.specific_items_to_install
                        and not self.specific_items_to_ignore
                    ):
                        for package_name in package_type[aspect_name]:
                            self.install_package(package_name)
                    elif aspect_name in self.specific_items_to_install:
                        for package_name in package_type[aspect_name]:
                            self.install_package(package_name)
                    elif (
                        aspect_name not in self.specific_items_to_ignore
                        and not self.specific_items_to_install
                        and self.specific_items_to_ignore
                    ):
                        for package_name in package_type[aspect_name]:
                            self.install_package(package_name)
        except KeyError:
            pass

    def install_package(self, package_name):
        pretty_name = helpers.pretty_log(log, log.info, package_name)
        if self.args.dry_run:
            log.log_info(f"Would install package '{pretty_name}'.")
            return

        if self.args.confirm and not helpers.confirm(
            f"Would you like to install the package '{pretty_name}'"
        ):
            return

        loader = Loader(log.log_info, log.log_error)
        try:
            loader.start(f"Installing package '{pretty_name}'")
            log_level = int(self.args.log_level) if self.args.log_level else -1
            install_package(
                package_name,
                log_level,
                confirm=self.args.confirm,
                package_type=self.package_type,
            )
            loader.success(f"Installed package '{pretty_name}'.")
        except subprocess.CalledProcessError:
            loader.failure(f"Failed to install package '{pretty_name}'.")
