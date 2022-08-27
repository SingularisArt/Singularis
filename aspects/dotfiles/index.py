#!/usr/bin/python3.10

from man.log import Log as Log

from man.operations.file import Files as Files
from man.operations.package import Packages as Packages
from man.operations.template import Templates as Templates


log = Log()

log.log_info("Installing my Dotfiles")

Files("dotfiles", specific_items_to_install)
# Templates("dotfiles", specific_items_to_install)
# Packages("dotfiles", specific_items_to_install)

log.log_success("Installed my Dotfiles")
