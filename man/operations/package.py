from man import InitClass as InitClass


class Package(InitClass):
    def __init__(self, package_name, args, package_type="aur"):
        InitClass.__init__(self)

        self.package_name = package_name
        self.package_type = package_type
        self.args = args


class Packages(InitClass, list):
    def __init__(self, aspect_name):
        InitClass.__init__(self)

        self.aspect_name = aspect_name
