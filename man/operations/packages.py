import man.helpers as helpers
from man import InitClass as InitClass
from man.helpers import install_package
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

        self.aspects_name = aspect_name
        self.specific_items_to_install = specific_items_to_install
        self.specific_items_to_ignore = specific_items_to_ignore
        self.args = args

        self.aspect_json_file_location = helpers.join(
            aspects_dir, self.aspects_name, "aspect.json"
        )
        self.data = helpers.load_data(
            self.aspect_json_file_location, self.aspects_name, log
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
                            install_package(
                                package_name,
                                confirm=args.confirm,
                                package_type=self.package_type,
                            )
                    elif aspect_name in self.specific_items_to_install:
                        for package_name in package_type[aspect_name]:
                            install_package(
                                package_name,
                                confirm=args.confirm,
                                package_type=self.package_type,
                            )
                    elif (
                        aspect_name not in self.specific_items_to_ignore
                        and not self.specific_items_to_install
                        and self.specific_items_to_ignore
                    ):
                        for package_name in package_type[aspect_name]:
                            install_package(
                                package_name,
                                confirm=args.confirm,
                                package_type=self.package_type,
                            )
        except KeyError:
            pass
