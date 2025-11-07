import json
import os
import re
import subprocess
import sys
import termios
import tty
from shutil import get_terminal_size


def load_data(file, aspect_name, log):
    if not os.path.exists(file):
        aspect_json = pretty_log(log, log.fatal, "aspect.json")
        name = pretty_log(log, log.fatal, aspect_name)
        log.log_fatal(f"Couldn't find {aspect_json} for {name}. Quitting.")

        return

    if os.path.exists(file):
        return json.load(open(file, "r"))
    else:
        raise FileNotFoundError(f"File {file} not found.")


def join(*args, seperator="/"):
    return seperator.join(str(e) for e in args if e)


def symlink(location, destination):
    if os.path.exists(destination):
        os.system(f"rm -rf {destination}")

    # os.makedirs(destination, exist_ok=True)
    os.symlink(location, destination)


def pretty_log(log, log_level, string):
    return (
        log_level["bg"]
        + log_level["fg"]
        + log_level["style"]
        + string
        + log.style["reset"]
    )


def get_keypress():
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    try:
        tty.setraw(sys.stdin.fileno())
        ch = sys.stdin.read(1)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
    return ch


def confirm(prompt):
    status = False
    print(f"{prompt} (Default: no) ", end="", flush=True)

    while True:
        key = get_keypress().lower()
        if key in ["y"]:
            status = True
            break
        elif key in ["n", "\r", "\n"]:
            status = False
            break
        else:
            print("\nPlease enter 'y' or 'n'", end="", flush=True)

    cols = get_terminal_size((80, 20)).columns
    print("\r" + " " * cols, end="\r")
    return status


def install_package(package, log_level, confirm=False, package_type="aur"):
    noconfirm = ""
    cmd = []

    if package_type == "aur":
        noconfirm = "--noconfirm" if not confirm else ""
        cmd = ["yay", "-S", package, noconfirm, "--needed"]
    elif package_type == "pacman":
        noconfirm = "--noconfirm" if not confirm else ""
        cmd = ["sudo", "pacman", "-S", package, noconfirm, "--needed"]
    elif package_type == "apt":
        noconfirm = "-y" if not confirm else ""
        cmd = [
            "sudo",
            "apt",
            "install",
            package,
            noconfirm,
            "--no-install-recommends",
        ]
    elif package_type == "apt-get":
        noconfirm = "-y" if not confirm else ""
        cmd = [
            "sudo",
            "apt-get",
            "install",
            package,
            noconfirm,
            "--no-install-recommends",
        ]
    elif package_type == "yum":
        noconfirm = "-y" if not confirm else ""
        cmd = ["sudo", "yum", "install", package, noconfirm]

    stdout = subprocess.PIPE if log_level > 2 or log_level == -1 else None
    stderr = subprocess.PIPE if log_level > 2 or log_level == -1 else None
    subprocess.run(
        cmd,
        stdout=stdout,
        stderr=stderr,
        check=True,
    )


def get_specific_items_to_install_and_ignore(name):
    if not name:
        return ("", "", "")

    specific_items_to_install = []
    specific_items_to_ignore = []

    try:
        search = re.search(r"(\w+)\((.+)\)?", name)
        if search:
            name = search.group(1)

            specific_items = search.group(2)
            if specific_items[0] == "^":
                if (
                    specific_items[1] == "("
                    and specific_items[-1] == ")"
                    and specific_items[-2] == ")"
                ):
                    specific_items_to_ignore = specific_items[2:-2].split(",")
                elif specific_items[1] == "(" and specific_items[-1] == ")":
                    specific_items_to_ignore = specific_items[2:-2].split(",")
                else:
                    specific_items_to_ignore = specific_items[1:-1].split(",")
                specific_items_to_install = []
            else:
                specific_items_to_ignore = []
                specific_items_to_install = specific_items[0:-1].split(",")
    except AttributeError:
        pass

    return name, specific_items_to_install, specific_items_to_ignore
