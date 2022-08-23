#!/usr/bin/python3.10

import argparse

from man.operations.config import Aspects as Aspects

# import man.helpers as helpers
# import man.variables as variables


def core(args):
    if args.all:
        print('All')
    if args.config:
        aspects = Aspects(args)
        if not aspects.all:
            [aspect.install_aspect() for aspect in aspects.install_aspects]


def settings(args):
    if args.colorscheme:
        print('Colorscheme')
    if args.distro:
        print('Distro')
    if args.settings:
        print('Settings')


def log(args):
    if args.log_level:
        print('Log')


def extra(args):
    if args.describe_config:
        print('Describe')


def list(args):
    if args.list_configs:
        print('List Configs')
    if args.list_distros:
        print('List Distros')


def parse_arguments(args):
    core(args)
    settings(args)
    log(args)
    extra(args)
    list(args)


def main():
    argparse.ArgumentParser()
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter
    )

    parser.add_argument(
        '-a', '--all',
        help='''Installs everything. Here's what it'll do.

1. Setup all of my configurations (You've been warned).
2. Setup all of my settings.
3. Install required aur and pacman packages.

Please, when running this command, be careful because you can wipe out all of
your hard work with my crappy work. To be safe, please check read this section
of the README: https://github.com/SingularisArt/Singularis#warning.

''',
        default=False,
        action='store_true',
    )
    parser.add_argument(
        '-c', '--config',
        help='''Installs individual configurations.

If you run `./install --config`, it'll install all the configurations.
If you run `./install --config "dotfiles"`, it'll install only my dotfiles.
If you run `./install --config "^dotfiles"`, it'll install everything except the
    dotfiles.

Run `./install --list-configs` to see the full list of configurations.

''',
        nargs="?",
        type=str,
        dest="config",
        const=" ",
    )

    parser.add_argument(
        '-r', '--colorscheme',
        help='''Generate the colorscheme required for most configurations.

''',
        default=False,
        action='store_true',
    )
    parser.add_argument(
        '-s', '--set-distro',
        help='''Change the default distro (Arch).

If you run `./install --set-distro "ubuntu"`, you'll change the default distro to
    Ubuntu.
It's important to note that if you use this command, you have to make it the
    first command like so: `./install --set-distro "kali" --all`.

Run `./install --list-distros` to see the full list of supported distros.

''',
        nargs="?",
        type=str,
        dest="distro",
        const=" ",
    )
    parser.add_argument(
        '-S', '--settings',
        help='''Execute the required settings.

''',
        default=False,
        action='store_true',
    )

    parser.add_argument(
        '-l', '--log',
        help='''Change the log level.

Log Levels include:
    1. Trace
    2. Debug
    3. Info (Default)
    4. Warn
    5. Error

''',
        nargs="?",
        type=str,
        dest="log_level",
        const=" ",
    )

    parser.add_argument(
        '-d', '--describe',
        help='''Describe the given configurations.

If you run `./install --describe dotfiles`, describe the dotfiles.

Run `./install --list-configs` to see the full list of configurations.

''',
        nargs="?",
        type=str,
        dest="describe_config",
        const=" ",
    )

    parser.add_argument(
        '-C', '--list-configs',
        help='''List all available configurations.

''',
        default=False,
        action='store_true',
    )
    parser.add_argument(
        '-D', '--list-distros',
        help='''List all the supported distros.

''',
        default=False,
        action='store_true',
    )

    parser.add_argument(
        '-i', '--singularis',
        help='''Don't run this command unless you're `singularis`.

''',
        default=False,
        action='store_true',
    )

    args = parser.parse_args()

    parse_arguments(args)


if __name__ == '__main__':
    main()
