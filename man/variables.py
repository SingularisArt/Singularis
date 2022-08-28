#!/usr/bin/env bash

import man.helpers as helpers

import os.path as path


HOME = path.expanduser("~")
LOCAL = helpers.join(HOME, ".local")
SHARE = helpers.join(LOCAL, "share")
BIN = helpers.join(LOCAL, "bin")
SINGULARIS = helpers.join(SHARE, "Singularis")
ASPECTS = helpers.join(SINGULARIS, "aspects")
THIRD_PARTY_TOOLS = helpers.join(
    SINGULARIS, "third-party-tools")
VENDOR = helpers.join(SINGULARIS, "vendor")
MEDIA = helpers.join(SINGULARIS, "media")
MAN = helpers.join(SINGULARIS, "man")
LOG_LEVEL_TXT = helpers.join(MAN, "log_level.txt")
LOCAL = helpers.join(HOME, ".local")
BACKUP = helpers.join(HOME, ".backup")
CONFIG = helpers.join(HOME, ".config")
