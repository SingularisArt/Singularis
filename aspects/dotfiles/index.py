#!/usr/bin/python3.10

from man.operations.file import Files as Files
from man.operations.package import Packages as Packages
from man.operations.template import Templates as Templates


# Template(
#     "dotfiles/templates/.gitconfig",
#     "~/.gitconfig",
#     values={
#         "user":         variables.USER,
#         "credential":   variables.CREDENTIAL,
#         "github":       variables.GITHUB,
#         "commit":       variables.COMMIT,
#     }
# ).copy_to_destination()

Files("dotfiles")
Templates("dotfiles")
Packages("dotfiles")
