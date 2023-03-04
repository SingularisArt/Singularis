#!/usr/bin/env python3

from man.log import Log as Log
from man.operations.file import Files as Files
from man.operations.packages import Packages as Packages
from man.operations.template import Templates as Templates
from man.operations.python import Python as Python
from man.operations.node import Node as Node
from man.operations.settings import Settings as Settings


log = Log()

log.log_notice("Installing required AUR packages.")

Files("aur", specific_items_to_install, specific_items_to_ignore, args)
Templates("aur", specific_items_to_install, specific_items_to_ignore, args)
Packages("aur", specific_items_to_ignore, specific_items_to_install, args)
Python("aur", specific_items_to_ignore, specific_items_to_install, args)
Node("aur", specific_items_to_ignore, specific_items_to_install, args)
Settings("aur", args)

log.log_success("Installed required AUR packages.")
