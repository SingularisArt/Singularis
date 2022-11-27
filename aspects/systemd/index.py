#!/usr/bin/env python3

from man.log import Log as Log
from man.operations.file import Files as Files
from man.operations.package import Packages as Packages
from man.operations.template import Templates as Templates


log = Log()

log.log_notice("Installing my Systemd Files.")

Files("systemd", specific_items_to_install, args)
Templates("systemd", specific_items_to_install, args)
Packages("systemd")

log.log_success("Installed my Systemd Files.")
