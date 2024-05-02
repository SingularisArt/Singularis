#!/usr/bin/env python3

from man.log import Log as Log
from man.operations.file import Files as Files
from man.operations.packages import Packages as Packages
from man.operations.template import Templates as Templates
from man.operations.library import Python as Python
from man.operations.library import Node as Node


log = Log()

log.log_notice("Installing my Email Setup.")

Files("email", specific_items_to_install, specific_items_to_ignore, args)
Templates("email", specific_items_to_install, specific_items_to_ignore, args)
Packages("email", specific_items_to_ignore, specific_items_to_install, args)
Python("email", specific_items_to_ignore, specific_items_to_install, args)
Node("email", specific_items_to_ignore, specific_items_to_install, args)

log.log_success("Installed my Email Setup.")
