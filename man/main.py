import argparse
import sys

from man import InitClass as InitClass

from man import helpers as helpers
from man.operations.aspects import Aspects as Aspects
from man.log import Log as Log

init = InitClass()


def core(args):
    if (args.aspect or args.all) and args.aspect != "false":
        aspects = Aspects(args)
        [aspect.install_aspect() for aspect in aspects["aspects_to_install"]]
    if (args.package or args.all) and args.package != "false":
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
    settings(args)


def main():
    argparse.ArgumentParser()
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter,
    )

    parser.add_argument(
        "-a",
        "--all",
        help="""Installs everything. Here's what it'll do.

1. Install all aspects (You've been warned).
2. Setup all settings.
3. Install required aur, pacman, apt, yum, and homebrew packages.
4. Generate colorscheme.
5. Install all required python libraries.
6. Install all required node-js libraries.

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

You can even disable the installation of the aspects:

`./install ... --aspect false`: Disables the installation of the aspects.

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
        "--packages",
        help="""Install all required packages.

You can install all the required packages:

`./install ... --packages`: Installs all required packages.

You can even disable the installation of the required packages:

`./install ... --packages false`: Disables the installation of the required packages.

You can specify what required packages you would like to install:

`./install ... --packages "dotfiles"`:          Install required packages for the `dotfiles` aspect.
`./install ... --packages "dotfiles email"`:    Install required packages for the `dotfiles` and `email` aspects.

You can even specify what required packages you don't want installed:

`./install ... --packages "^dotfiles"`:         Install all required packages except the packages for the `dotfiles` aspect.
`./install ... --packages "^(dotfiles email)"`: Install all required packages except the packages for the `dotfiles` and `email` aspects.

You can get even picker. You can specify what required packages for sub-aspects (called configurations) you want installed.

`./install ... --packages "dotfiles(lf)"`:          Only install the required packages for the `lf` configuration within the `dotfiles` aspect.
`./install ... --packages "dotfiles(lf,kitty)"`:    Only install the required packages for the `lf` and `kitty` configurations within the `dotfiles` aspect.

Just like above, you can specify what required packages for configurations you don't want installed.

`./install ... --packages "dotfiles(^lf))"`:        Install all the required packages within the `dotfiles` aspect except for the `lf` configuration.
`./install ... --packages "dotfiles(^(lf,kitty))"`: Install all the required packages within the `dotfiles` aspect except for the `lf` and `kitty` configurations.

NOTE: The `...` just means the other commands that you're passing into the installation script. You don't have to add those.

""",
        nargs="?",
        type=str,
        dest="package",
        const=" ",
    )
    parser.add_argument(
        "-P",
        "--python",
        help="""Install all required python libaries.

You can install all the required python libraries:

`./install ... --python`: Installs all required python libraries.

You can even disable the installation of the required python libraries:

`./install ... --python false`: Disables the installation of the required python libraries.

You can specify what required python libraries you would like to install:

`./install ... --python "dotfiles"`:        Install required python libraries for the `dotfiles` aspect.
`./install ... --python "dotfiles email"`:  Install required python libraries for the `dotfiles` and `email` aspects.

You can even specify what required python libraries you don't want installed:

`./install ... --python "^dotfiles"`:         Install all required python libraries except the required python libraries for the `dotfiles` aspect.
`./install ... --python "^(dotfiles email)"`: Install all required python libraries except the required python libraries for the `dotfiles` and `email` aspects.

You can get even picker. You can specify what required python libraries for sub-aspects (called configurations) you want installed.

`./install ... --python "dotfiles(lf)"`:        Only install the required python libraries for the `lf` configuration within the `dotfiles` aspect.
`./install ... --python "dotfiles(lf,kitty)"`:  Only install the required python libraries for the `lf` and `kitty` configurations within the `dotfiles` aspect.

Just like above, you can specify what required python libraries for configurations you don't want installed.

`./install ... --python "dotfiles(^lf))"`:        Install all the required python libraries within the `dotfiles` aspect except for the `lf` configuration.
`./install ... --python "dotfiles(^(lf,kitty))"`: Install all the required python libraries within the `dotfiles` aspect except for the `lf` and `kitty` configurations.

NOTE: The `...` just means the other commands that you're passing into the installation script. You don't have to add those.

""",
        nargs="?",
        type=str,
        dest="python",
        const=" ",
    )
    parser.add_argument(
        "-n",
        "--node",
        help="""Install all required node-js libaries.

You can install all the required node libraries:

`./install ... --node`: Installs all required node libraries.

You can even disable the installation of the required node libraries:

`./install ... --node false`: Disables the installation of the required node libraries.

You can specify what required node libraries you would like to install:

`./install ... --node "dotfiles"`:        Install required node libraries for the `dotfiles` aspect.
`./install ... --node "dotfiles email"`:  Install required node libraries for the `dotfiles` and `email` aspects.

You can even specify what required node libraries you don't want installed:

`./install ... --node "^dotfiles"`:         Install all required node libraries except the required node libraries for the `dotfiles` aspect.
`./install ... --node "^(dotfiles email)"`: Install all required node libraries except the required node libraries for the `dotfiles` and `email` aspects.

You can get even picker. You can specify what required node libraries for sub-aspects (called configurations) you want installed.

`./install ... --node "dotfiles(lf)"`:        Only install the required node libraries for the `lf` configuration within the `dotfiles` aspect.
`./install ... --node "dotfiles(lf,kitty)"`:  Only install the required node libraries for the `lf` and `kitty` configurations within the `dotfiles` aspect.

Just like above, you can specify what required node libraries for configurations you don't want installed.

`./install ... --node "dotfiles(^lf))"`:        Install all the required node libraries within the `dotfiles` aspect except for the `lf` configuration.
`./install ... --node "dotfiles(^(lf,kitty))"`: Install all the required node libraries within the `dotfiles` aspect except for the `lf` and `kitty` configurations.

NOTE: The `...` just means the other commands that you're passing into the installation script. You don't have to add those.

""",
        nargs="?",
        type=str,
        dest="nodejs",
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
        "-s",
        "--settings",
        help="Setup the required settings.",
        default=False,
        action="store_true",
    )
    parser.add_argument(
        "-A",
        "--list-aspects",
        help="List all available aspects.",
        default=False,
        action="store_true",
    )

    parser.add_argument(
        "-i",
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
            "You didn't pass any commands. Run `./install --help`"
            + "to see the full list."
        )

        return

    args = parser.parse_args()
    parse_arguments(args)


if __name__ == "__main__":
    main()
