import json
import os


def load_data(file):
    if os.path.exists(file):
        # Load the json file
        opened_file = open(file, "r")

        # Get the json contentents
        return json.load(opened_file)
    else:
        return False


def join(*args, seperator="/"):
    return seperator.join(str(e) for e in args if e)


def symlink(location, destination):
    os.system('rm -rf {}'.format(destination))
    os.makedirs(os.path.dirname(destination), exist_ok=True)
    os.symlink(location, destination)
