#!/usr/bin/env python3

from man.log import Log as Log
from man.operations.file import Files as Files
from man.operations.packages import Packages as Packages
from man.operations.template import Templates as Templates
from man.operations.python import Pythons as Pythons
from man.operations.node import Nodes as Nodes
from man.operations.settings import Settings as Settings


log = Log()

log.log_notice("Installing my Email Setup.")

Files("email", specific_items_to_install, specific_items_to_ignore, args)
# Templates("email", specific_items_to_install, specific_items_to_ignore, args)
# Packages("email", specific_items_to_ignore, specific_items_to_install, args)
# Pythons("email", specific_items_to_ignore, specific_items_to_install, args)
# Nodes("email", specific_items_to_ignore, specific_items_to_install, args)
# Settings("email", args)

log.log_success("Installed my Email Setup.")
