import json


def load_data(file):
    # Load the json file
    opened_file = open(file, "r")

    # Get the json contentents
    return json.load(opened_file)


def join(*args, seperator="/"):
    return seperator.join(str(e) for e in args if e)
