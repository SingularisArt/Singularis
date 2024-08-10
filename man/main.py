import argparse
import sys

from man import InitClass as InitClass
from man.log import Log as Log
from man.operations.aspects import Aspects as Aspects

init = InitClass()


def core(args):
    aspects = Aspects(args)

    # Move the packages aspect to the front of the list.
    for x, aspect in enumerate(aspects["aspects_to_install"]):
        if "packages" == aspect.__repr__():
            aspects["aspects_to_install"].pop(x)
            aspects["aspects_to_install"].insert(0, aspect)

    [aspect.install_aspect() for aspect in aspects["aspects_to_install"]]


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


def lists(args):
    if args.list_aspects:
        print("List Aspects")


def parse_arguments(args):
    log(args)
    core(args)
    lists(args)


def main():
    argparse.ArgumentParser()
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter,
    )

    parser.add_argument(
        "-a",
        "--all",
        help="""Installs everything. Here's what it'll do.

1. Install all aspects. (You've been warned).
2. Install required aur, pacman, apt, yum, and homebrew packages.
3. Install all required python libraries.
4. Install all required node-js libraries.
5. Generate colorscheme.

Please, when running this command, be careful because you can wipe out all of your hard work with my crappy work. To be safe, please check read this section of the README: https://github.com/SingularisArt/Singularis#warning.

NOTE: If you really want to run the installation script with this parameter, this could take a couple of hours.

""",
        default=False,
        action="store_true",
    )
    parser.add_argument(
        "-c",
        "--aspect",
        help="""Install all required aspects.

You can install all the aspects:

`./install ... --aspect`: Install all aspects.

You can specify what aspects you would like to install:

`./install ... --aspect "dotfiles"`:        Install only the `dotfiles` aspect.
`./install ... --aspect "dotfiles email"`:  Install only the `dotfiles` and `email` aspects.

You can even specify what aspects you don't want installed:

`./install ... --aspect "^dotfiles"`:           Install everything except the `dotfiles` aspect.
`./install ... --aspect "^(dotfiles email)"`:   Install everything except the `dotfiles` and `email` aspects.

You can even get picker. You can specify what sub-aspects (called configurations) you want installed only:

`./install ... --aspect "dotfiles(lf)"`:        Install only the `lf` configuration within the `dotfiles` aspect.
`./install ... --aspect "dotfiles(lf,kitty)"`:  Install only the `lf` and `kitty` configurations within the `dotfiles` aspect.

Just like above, you can specify what configurations you don't want installed:

`./install ... --aspect "dotfiles(^lf)"`:           Install everything except the `lf` configuration within the `dotfiles` aspect.
`./install ... --aspect "dotfiles(^(lf,kitty))"`:   Install everything except the `lf` and `kitty` configuration within the `dotfiles` aspect.

NOTE: The `...` just means the other commands that you're passing into the installation script. You don't have to add those.

""",
        nargs="?",
        type=str,
        dest="aspect",
        const=" ",
    )
    parser.add_argument(
        "-p",
        "--no-packages",
        help="Disable the installation of the required packages.",
        default=False,
        action="store_true",
    )
    parser.add_argument(
        "-y",
        "--no-python",
        help="Disable the installation of the required python libraries.",
        default=False,
        action="store_true",
    )
    parser.add_argument(
        "-n",
        "--no-node",
        help="Disable the installation of the required node libraries.",
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
        "-t",
        "--package-type",
        help="""Change the package type.

Available Options:
    Arch:   aur     (Default)
    Arch:   pacman
    Ubuntu: apt
    Ubuntu: apt-get
    RedHat: yum

""",
        nargs="?",
        type=str,
        dest="package_type",
        default="aur",
    )

    parser.add_argument(
        "-A",
        "--list-aspects",
        help="List all available aspects.",
        default=False,
        action="store_true",
    )

    parser.add_argument(
        "-s",
        "--singularis",
        help="Don't run this command unless you're `singularis`.",
        default=False,
        action="store_true",
    )
    parser.add_argument(
        "-C",
        "--confirm",
        help="Prompt for confirmation at each step.",
        default=False,
        action="store_true",
    )
    parser.add_argument(
        "-d",
        "--dry-run",
        help="Don't install anything. Only display what will happen.",
        default=False,
        action="store_true",
    )

    if not len(sys.argv) > 1:
        LOG = Log()
        LOG.log_fatal(
            "You didn't pass any commands. Run `./install --help` "
            + "to see the full list."
        )

        return

    args = parser.parse_args()
    parse_arguments(args)


if __name__ == "__main__":
    main()
