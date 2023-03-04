from man import InitClass as InitClass
import man.helpers as helpers
from man.log import Log as Log
from man.variables import aspects_dir


log = Log()


class Package(InitClass):
    def __init__(self, package_name, args):
        InitClass.__init__(self)

        self.package_name = package_name
        self.args = args
        self.package_type = self.args.package_type


class Packages(InitClass, list):
    def __init__(
        self,
        aspect_name,
        specific_items_to_install,
        specific_items_to_ignore,
        args,
    ):
        InitClass.__init__(self)

        self.aspects_name = aspect_name
        self.specific_items_to_install = specific_items_to_install
        self.specific_items_to_ignore = specific_items_to_ignore
        self.args = args

        # (
        #     self.package_name,
        #     self.specific_items_to_install,
        #     self.specific_items_to_ignore,
        # ) = helpers.get_specific_items_to_install_and_ignore(args.package)

        # self.aspect_json_file_location = helpers.join(
        #     aspects_dir, self.aspects_name, "aspect.json"
        # )
        # self.data = helpers.load_data(
        #     self.aspect_json_file_location, self.aspects_name, log
        # )

        # if not args.package_type:
        #     self.package_type = "aur"
        # else:
        #     self.package_type = args.package_type

        # for package_type in self.data["packages"]:
        #     # Continue
        #     pass
