import json
import os
import subprocess


def load_data(file):
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


def confirm(prompt):
    while True:
        choice = input(f"{prompt} (Default: no) ").lower()
        if choice in ["yes", "y"]:
            return True
        elif choice in ["no", "n", ""]:
            return False
        else:
            print("Please enter \"yes\", \"y\" or \"no\", \"n\"")


def install_aur_package(package):
    subprocess.run(["yay", "-S", package, "--noconfirm", "--needed"])


def install_apt_package(package):
    subprocess.run(["sudo", "apt-get", package, "--no-install-recommends", "-y"])
