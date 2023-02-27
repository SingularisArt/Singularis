from man import InitClass as InitClass


class Settings(InitClass):
    def __init__(self, aspect_name, args):
        InitClass.__init__(self)

        self.aspect_name = aspect_name
        self.args = args
