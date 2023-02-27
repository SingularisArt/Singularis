from man import InitClass as InitClass


class Python(InitClass):
    def __init__(
        self,
        python_library_name,
        specific_items_to_install,
        specific_items_to_ignore,
        args,
    ):
        InitClass.__init__(self)

        self.python_library_name = python_library_name
        self.specific_items_to_install = specific_items_to_install
        self.specific_items_to_ignore = specific_items_to_ignore
        self.args = args


class Pythons(InitClass, list):
    def __init__(
        self,
        aspect_name,
        specific_items_to_install,
        specific_items_to_ignore,
        args,
    ):
        InitClass.__init__(self)

        self.aspect_name = aspect_name
        self.specific_items_to_install = specific_items_to_install
        self.specific_items_to_ignore = specific_items_to_ignore
        self.args = args
