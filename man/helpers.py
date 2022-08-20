import json


def load_data(file, recursive=False, values=[]):
    # Load the json file
    opened_file = open(file, "r")
    # Get the json contentents
    data = json.load(opened_file)

    # Return the data parsed from the json data
    return [data[var] for var in values]


def join(*args, seperator=" "):
    return seperator.join(str(e) for e in args if e)
