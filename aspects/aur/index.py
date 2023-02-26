#!/usr/bin/env python3

from man.log import Log as Log
from man.operations.package import Packages as Packages


log = Log()

log.log_notice("Installing required AUR packages.")

Packages("aur", specific_items_to_ignore, specific_items_to_install, args)

log.log_success("Installed required AUR packages.")
