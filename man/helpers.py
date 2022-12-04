import json
import os


def load_data(file: str) -> dict:
    if os.path.exists(file):
        return json.load(open(file, "r"))
    else:
        raise FileNotFoundError(f"File {file} not found.")


def join(*args, seperator="/"):
    return seperator.join(str(e) for e in args if e)


def symlink(location, destination):
    os.system("rm -rf {}".format(destination))
    os.makedirs(os.path.dirname(destination), exist_ok=True)
    os.symlink(location, destination)


def pretty_log(log, log_level, string):
    return (
        log_level["bg"]
        + log_level["fg"]
        + log_level["style"]
        + string
        + log.style["reset"]
    )
