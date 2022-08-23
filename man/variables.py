#!/usr/bin/env bash

import man.helpers as helpers

import os.path as path


HOME = path.expanduser("~")
SINGULARIS = helpers.join(HOME, "Singularis")

ASPECTS = helpers.join(SINGULARIS, "aspects")
THIRD_PARTY_TOOLS = helpers.join(
    SINGULARIS, "third-party-tools")
VENDOR = helpers.join(SINGULARIS, "vendor")
MEDIA = helpers.join(SINGULARIS, "media")
MAN = helpers.join(SINGULARIS, "man")
LOCAL = helpers.join(HOME, ".local")
BACKUP = helpers.join(HOME, ".backup")
CONFIG = helpers.join(HOME, ".config")
