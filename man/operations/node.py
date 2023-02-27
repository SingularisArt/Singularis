from man import InitClass as InitClass


class Node(InitClass):
    def __init__(
        self,
        node_library_name,
        specific_items_to_install,
        specific_items_to_ignore,
        args,
    ):
        InitClass.__init__(self)

        self.node_library_name = node_library_name
        self.specific_items_to_install = specific_items_to_install
        self.specific_items_to_ignore = specific_items_to_ignore
        self.args = args


class Nodes(InitClass, list):
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
