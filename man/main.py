import argparse
import sys

from man import InitClass as InitClass

from man import helpers as helpers
from man.operations.aspects import Aspects as Aspects
from man.log import Log as Log

init = InitClass()


def core(args):
    if args.aspect or args.all:
        aspects = Aspects(args)
        [aspect.install_aspect() for aspect in aspects["aspects_to_install"]]


def settings(args):
    if args.settings or args.all:
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

1. Setup all of my aspects (You've been warned).
2. Setup all of my settings.
3. Install required aur and pacman packages.
4. Generate colorscheme.

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
        help="""Installs individual aspects.

`./install ... --aspect`:                               Install all aspects.
`./install ... --aspect "dotfiles"`:                    Install only the `dotfiles` aspect.
`./install ... --aspect "dotfiles,email"`:              Install only the `dotfiles` and `email` aspects.
`./install ... --aspect "^dotfiles"`:                   Install everything except the `dotfiles` aspect.
`./install ... --aspect "dotfiles(lf,kitty)"`:          Install only the `lf` and `kitty` configuration within the `dotfiles` aspect.
`./install ... --aspect "dotfiles(lf,kitty),..."`:      Install only the `lf` and `kitty` configuration within the `dotfiles` aspect.
`./install ... --aspect "dotfiles(^(lf,kitty)),..."`:   Install everything except the `lf` and `kitty` configuration within the `dotfiles` aspect.

""",
        nargs="?",
        type=str,
        dest="aspect",
        const=" ",
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
        "-p",
        "--packages",
        help="""Install all the required packages.

`./install ... --packages`:                         Installs all required packages.
`./install ... --packages false`:                   Doesn't install required packages.
`./install ... --packages "dotfiles"`:              Install required packages for my dotfiles aspect.
`./install ... --packages "dotfiles(lf,kitty)"`:    Install required packages for my `lf` and `kitty` configuration within my `dotfiles` aspect.
`./install ... --packages "dotfiles(^(lf,kitty))"`: Install required packages within my dotfiles aspect except for `lf` and `kitty`.
`./install ... --packages "^dotfiles"`:             Install all required packages except the packages for the `dotfiles` aspect.

""",
        nargs="?",
        type=str,
        dest="packages",
        const=" ",
    )

    parser.add_argument(
        "-A",
        "--list-aspects",
        help="""List all available aspects.

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
    parser.add_argument(
        "-C",
        "--confirm",
        help="""Prompt for confirmation at each step.

""",
        default=False,
        action="store_true",
    )
    parser.add_argument(
        "-d",
        "--dry-run",
        help="""Don't install anything. Only display what will happen.

""",
        default=False,
        action="store_true",
    )

    args = parser.parse_args()

    parse_arguments(args)

    if not len(sys.argv) > 1:
        LOG = Log()
        LOG.log_fatal(
            "You didn't pass any commands. Run `./install --help`"
            + "to see the full list."
        )


if __name__ == "__main__":
    main()
