"""
This module consists of multiple functions that do simple tasks so you don't
have to keep re-typing them.

Attributes:
    load_data(file: str) -> dict:
        Load the data from the given file.

        Args:
            file (str): The path to the file.

        Returns:
            dict: The loaded data from the given file if it exists.
            boolean (False): If the file doesn't exist.

        Raises:
            FileNotFoundError: If the file doesn't exist.
"""

import json
import os


def load_data(file: str) -> dict:
    """
    Load the data from the given file.

    Args:
    -----
        file (str): The path to the file.

    Returns:
    --------
        dict: The loaded data from the given file if it exists.
        boolean (False): If the file doesn't exist.

    Raises:
    -------
        FileNotFoundError: If the file doesn't exist.

    Examples:
    ---------
    """

    if os.path.exists(file):
        # Load the json file and return.
        return json.load(open(file, "r"))
    else:
        # Raise if couldn't find file.
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
