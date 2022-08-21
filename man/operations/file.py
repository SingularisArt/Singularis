#!/usr/bin/python3.10

import os
from pathlib import Path

from man import InitClass as InitClass
import man.helpers as helpers


class File(InitClass):
    def __init__(self, file_path, destination):
        InitClass.__init__(self)

        self.file_path = file_path
        self.name = Path(self.file_path).name
        self.file_destination = destination

    def install_file(self):
        os.system('rm -rf {}'.format(self.file_destination))
        os.makedirs(os.path.dirname(self.file_destination), exist_ok=True)
        os.symlink(self.file_path, self.file_destination)


class Files(InitClass):
    def __init__(self, root_folder, values={}):
        InitClass.__init__(self)

        self.root_folder = root_folder
        self.values = values

        self.check_sum()

        [
            File(
                helpers.join(self.root_folder, key),
                self.values[key]
            ).install_file() for key in self.values
        ]

    def check_sum(self):
        pass
