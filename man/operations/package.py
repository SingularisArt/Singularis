from man import InitClass as InitClass


class Package(InitClass):
    def __init__(self):
        InitClass.__init__(self)


class Packages(InitClass, list):
    def __init__(self, aspect_name):
        InitClass.__init__(self)
