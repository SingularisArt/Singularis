#!/usr/bin/python3.10

import argparse

from man.operations.config import Aspects as Aspects

# import man.helpers as helpers
# import man.variables as variables


def core(args):
    # if args.all:
    #     print('All')
    if args.config:
        aspects = Aspects(args)
        if not aspects.all:
            [aspect.install_aspect() for aspect in aspects.install_aspects]

    # if args.local:
    #     print('Local')
    # if args.packages:
    #     print('Packages')


def settings(args):
    if args.colorscheme:
        print('Colorscheme')
    if args.set_distro:
        print('Distro')
    if args.settings:
        print('Settings')


def libraries(args):
    if args.npm:
        print('NPM')
    if args.python:
        print('Python')


def log(args):
    if args.log:
        print('Log')


def extra(args):
    if args.describe:
        print('Describe')


def list(args):
    if args.list_configs:
        print('List Configs')
    if args.list_local:
        print('List Local')
    if args.list_distros:
        print('List Distros')


def parse_arguments(args):
    core(args)
    # settings(args)
    # libraries(args)
    # log(args)
    # extra(args)
    # list(args)


def main():
    argparse.ArgumentParser()
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter
    )

    parser.add_argument(
        '-a', '--all',
        help='''Installs everything. It will setup

1. All the required packages.
2. All the configurations.
3. All the required settings.
4. All the required npm libraries.
5. All the required python libraries.

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
If you run `./install --config dotfiles`, it'll install only my dotfiles.
If you run `./install --config ^dotfiles`, it'll install everything except the
    dotfiles.

Run `./install --list-configs` to see the full list of configurations.

''',
        nargs="?",
        type=str,
        dest="config",
        const=" ",
    )
#     parser.add_argument(
#         '-l', '--local',
#         help='''Install all the required man and application data.

# If you run `./install --local bin`, it'll install all the required man.
# If you run `./install --local bin ani-cli`, it'll install only the ani-cli
#     script.
# If you run `./install --local bin ^ani-cli`, it'll install everything except
#     the ani-cli script.

# If you run `./install --local share`, it'll install all application data.
# If you run `./install --local share castero`, it'll install only the
#     application data for castero.
# If you run `./install --local share ^castero`, it'll install everything except
#     the application data for castero.

# If you run `./install --local`, it'll install both.

# ''',
#         default=False,
#         action='store_true',
#     )
#     parser.add_argument(
#         '-p', '--packages',
#         help='''Install all the required packages.

# If you aren't on an Arch based distro, then you should run
#     `./install --set-distro ubuntu` to change the distro. This will change all
#     the installed packages to work with your distro.

# Run `./install --list-distros` to see the full list of supported distros.

# ''',
#         default=False,
#         action='store_true',
#     )

#     parser.add_argument(
#         '-r', '--colorscheme',
#         help='''Generate the colorscheme required for most configurations.

# ''',
#         default=False,
#         action='store_true',
#     )
#     parser.add_argument(
#         '-s', '--set-distro',
#         help='''Change the default distro (Arch).

# If you run `./install --set-distro ubuntu`, you'll change the default distro to
#     Ubuntu.
# It's important to note that if you use this command, you have to make it the
#     first command like so: `./install --set-distro kali --all`.

# Run `./install --list-distros` to see the full list of supported distros.

# ''',
#         default=False,
#         action='store_true',
#     )
#     parser.add_argument(
#         '-S', '--settings',
#         help='''Execute the required settings.

# ''',
#         default=False,
#         action='store_true',
#     )

#     parser.add_argument(
#         '-n', '--npm',
#         help='''Install the required npm libraries.

# ''',
#         default=False,
#         action='store_true',
#     )
#     parser.add_argument(
#         '-P', '--python',
#         help='''Install the required python libraries.

# ''',
#         default=False,
#         action='store_true',
#     )

#     parser.add_argument(
#         '-o', '--log',
#         help='''Change the log level.

# ''',
#         default=False,
#         action='store_true',
#     )

#     parser.add_argument(
#         '-d', '--describe',
#         help='''Describe the given configurations.

# If you run `./install --describe dotfiles`, describe the dotfiles.

# Run `./install --list-configs` to see the full list of configurations.

# ''',
#         default=False,
#         action='store_true',
#     )

#     parser.add_argument(
#         '-C', '--list-configs',
#         help='''List all available configurations.

# ''',
#         default=False,
#         action='store_true',
#     )
#     parser.add_argument(
#         '-L', '--list-local',
#         help='''List all man and application data that will be installed.

# ''',
#         default=False,
#         action='store_true',
#     )
#     parser.add_argument(
#         '-D', '--list-distros',
#         help='''List all supported distros.

# ''',
#         default=False,
#         action='store_true',
#     )

#     parser.add_argument(
#         '-u', '--singularis',
#         help='''Don't run this command unless you're `singularis`.

# ''',
#         default=False,
#         action='store_true',
#     )

    args = parser.parse_args()

    parse_arguments(args)


if __name__ == '__main__':
    main()
