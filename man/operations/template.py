import string
import os

from man import InitClass as InitClass
from man import helpers as helpers


class CustomTemplate(string.Template):
    delimiter = "^"


class Template(InitClass):
    def __init__(self, template_location,
                 template_destination,
                 values={},
                 delimiter="^"):
        InitClass.__init__(self)

        self.template_location = helpers.join(
            self.aspects_dir,
            template_location
        )
        self.template_destination = os.path.expanduser(template_destination)
        self.values = values

        with open(self.template_location, 'r') as in_template:
            data = in_template.read()

        template = CustomTemplate(data)
        self.output = template.safe_substitute(**self.values)

    def copy_to_destination(self):
        try:
            open(self.template_destination, 'x')
        except FileExistsError:
            pass

        with open(self.template_destination, 'w') as out_template:
            out_template.write(self.output)
