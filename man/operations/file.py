#!/usr/bin/python3.10

import os

from man import InitClass as InitClass
import man.helpers as helpers


class File(InitClass):
    def __init__(self, file_name, root_folder, type):
        InitClass.__init__(self)

        self.root_folder = root_folder
        self.name = file_name
        self.type = type
        self.file_location = helpers.join(
            self.root_folder,
            '.' + self.type,
            self.name
        )
        self.file_destination = self.get_location()

        # TODO: Implement this function
        if self.check_sum():
            self.install()

    def get_location(self):
        if self.type == 'config':
            return helpers.join(self.config_dir, self.name)
        elif self.type == 'home':
            return helpers.join(self.home_dir, self.name)
        elif self.type == 'local':
            return helpers.join(self.local_dir, self.name)

    def install(self):
        if self.type != 'local':
            helpers.symlink(self.file_location, self.file_destination)
        else:
            for file in os.listdir(self.file_location):
                file_location = helpers.join(self.file_location, file)
                file_destination = helpers.join(self.file_destination, file)
                helpers.symlink(file_location, file_destination)
        return

    def check_sum(self):
        return True

    def __repr__(self):
        return self.name


class Files(InitClass, dict):
    def __init__(self, root_folder):
        InitClass.__init__(self)

        self.root_folder = helpers.join(
            self.aspects_dir,
            root_folder,
            'files'
        )

        config = helpers.join(self.root_folder, '.config')
        home = helpers.join(self.root_folder, '.home')
        local = helpers.join(self.root_folder, '.local')

        self.config = config if os.path.exists(config) else None
        self.home = home if os.path.exists(home) else None
        self.local = local if os.path.exists(local) else None

        self.files = self.root_folder

        dict.__init__(self, self.get_files())

    def get_files(self):
        files = {
            "home": [],
            "config": [],
            "local": [],
        }

        # Getting .config files
        for file in os.listdir(self.config):
            file = File(file, self.root_folder, type='config')
            files["config"].append(file)
        # Getting .home files
        for file in os.listdir(self.home):
            file = File(file, self.root_folder, type='home')
            files["home"].append(file)
        # Getting .local files
        for file in os.listdir(self.local):
            file = File(file, self.root_folder, type='local')
            files["local"].append(file)

        return files
