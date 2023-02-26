#!/usr/bin/python3.10

from man.log import Log as Log

from man.operations.file import Files as Files
from man.operations.package import Packages as Packages
from man.operations.template import Templates as Templates


log = Log()

log.log_notice("Installing my NeoVim configuration.")

Files("nvim", specific_items_to_install, specific_items_to_ignore, args)
Templates("nvim", specific_items_to_install, specific_items_to_ignore, args)
# Packages("nvim", specific_items_to_ignore, specific_items_to_install, args)

log.log_success("Installed my NeoVim configuration.")
