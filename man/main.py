#!/usr/bin/python3.10

import argparse

from man import InitClass as InitClass
# from man import helpers as helpers
from man.operations.aspects import Aspects as Aspects

init = InitClass()


def core(args):
    if args.all:
        print("All")
    if args.aspect:
        aspects = Aspects(args)
        [aspect.install_aspect() for aspect in aspects["aspects_to_install"]]


def settings(args):
    if args.colorscheme:
        print("Colorscheme")
    if args.distro:
        print("Distro")
    if args.settings:
        print("Settings")


def log(args):
    try:
        open(init.log_level_txt, "x")
    except FileExistsError:
        pass
    except FileNotFoundError:
        return

    with open(init.log_level_txt, "w") as f:
        if args.log_level:
            f.write(args.log_level)
        else:
            f.write("3")


def extra(args):
    if args.describe_config:
        print("Describe")


def list(args):
    if args.list_configs:
        print("List Configs")
    if args.list_distros:
        print("List Distros")


def parse_arguments(args):
    log(args)
    settings(args)
    core(args)
    extra(args)
    list(args)


def main():
    argparse.ArgumentParser()
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter)

    parser.add_argument(
        "-a",
        "--all",
        help="""Installs everything. Here's what it'll do.

1. Setup all of my configurations (You've been warned).
2. Setup all of my settings.
3. Install required aur and pacman packages.

Please, when running this command, be careful because you can wipe out all of
your hard work with my crappy work. To be safe, please check read this section
of the README: https://github.com/SingularisArt/Singularis#warning.

""",
        default=False,
        action="store_true",
    )
    parser.add_argument(
        "-c",
        "--aspect",
        help="""Installs individual configurations.

If you run `./install --aspect`, it'll install all the configurations.
If you run `./install --aspect "dotfiles"`, it'll install only my dotfiles.
If you run `./install --aspect "^dotfiles"`, it'll install everything except
    the dotfiles.

Run `./install --list-configs` to see the full list of configurations.

""",
        nargs="?",
        type=str,
        dest="aspect",
        const=" ",
    )

    parser.add_argument(
        "-r",
        "--colorscheme",
        help="""Generate the colorscheme required for most configurations.

""",
        default=False,
        action="store_true",
    )
    parser.add_argument(
        "-s",
        "--set-distro",
        help="""Change the default distro (Arch).

If you run `./install --set-distro "ubuntu"`, you'll change the default distro
    to Ubuntu.
It's important to note that if you use this command, you have to make it the
    first command like so: `./install --set-distro "kali" --all`.

Run `./install --list-distros` to see the full list of supported distros.

""",
        nargs="?",
        type=str,
        dest="distro",
        const=" ",
    )
    parser.add_argument(
        "-S",
        "--settings",
        help="""Execute the required settings.

""",
        default=False,
        action="store_true",
    )

    parser.add_argument(
        "-l",
        "--log",
        help="""Change the log level.

Log Levels include:
    Off:        -1
    All:         0
    Trace:       1
    Debug:       2
    Info:        3 (Default)
    Notice:      4
    Warn:        5
    Error:       6
    Fatal:       7
    Success:     8

""",
        nargs="?",
        type=str,
        dest="log_level",
        const=" ",
    )

    parser.add_argument(
        "-d",
        "--describe",
        help="""Describe the given configurations.

If you run `./install --describe dotfiles`, describe the dotfiles.

Run `./install --list-configs` to see the full list of configurations.

""",
        nargs="?",
        type=str,
        dest="describe_config",
        const=" ",
    )

    parser.add_argument(
        "-C",
        "--list-configs",
        help="""List all available configurations.

""",
        default=False,
        action="store_true",
    )
    parser.add_argument(
        "-D",
        "--list-distros",
        help="""List all the supported distros.

""",
        default=False,
        action="store_true",
    )

    parser.add_argument(
        "-i",
        "--singularis",
        help="""Don't run this command unless you're `singularis`.

""",
        default=False,
        action="store_true",
    )

    args = parser.parse_args()

    parse_arguments(args)


if __name__ == "__main__":
    main()
