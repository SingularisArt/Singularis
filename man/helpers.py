import errno
import json
import os


def load_data(file):
    # Load the json file
    opened_file = open(file, "r")

    # Get the json contentents
    return json.load(opened_file)


def join(*args, seperator="/"):
    return seperator.join(str(e) for e in args if e)


def force_symlink(file1, file2):
    try:
        os.symlink(file1, file2)
    except OSError as e:
        if e.errno == errno.EEXIST:
            os.remove(file2)
            os.symlink(file1, file2)
