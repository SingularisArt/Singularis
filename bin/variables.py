#!/usr/bin/env bash

import helpers

import os.path as path

HOME = path.expanduser("~")
SINGULARIS = helpers.join(HOME, "Singularis", seperator="/")

CONFIG = helpers.join(SINGULARIS, "config", seperator="/")
BIN = helpers.join(SINGULARIS, "bin", seperator="/")
THIRD_PARTY_TOOLS = helpers.join(
    SINGULARIS, "third-party-tools", seperator="/")
MEDIA = helpers.join(SINGULARIS, "media", seperator="/")
SCRIPTS = helpers.join(SINGULARIS, "scripts", seperator="/")
INSTALL_SCRIPTS = helpers.join(SCRIPTS, "install", seperator="/")
UNINSTALL_SCRIPTS = helpers.join(SCRIPTS, "uninstall", seperator="/")
LOCAL = helpers.join(SINGULARIS, "local", seperator="/")
BACKUP_LOCATION = helpers.join(
    SINGULARIS, "backup-configuration", seperator="/")
CONFIG_LOCATION = helpers.join(HOME, ".config", seperator="/")
