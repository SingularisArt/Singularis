#!/usr/bin/python3.10

from man.log import Log as Log

from man.operations.file import Files as Files
from man.operations.package import Packages as Packages
from man.operations.template import Templates as Templates


log = Log()

log.log_notice("Installing my NeoVim configuration.")

specific_items_to_install = ""

Files("nvim", specific_items_to_install, args)
Templates("nvim", specific_items_to_install, args)
Packages("nvim")

log.log_success("Installed my NeoVim configuration.")
