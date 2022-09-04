#!/usr/bin/env bash


from pathlib import Path
import os

import man.helpers as helpers


HOME = Path(os.path.expanduser("~")).expanduser()
LOCAL = Path(helpers.join(HOME, ".local")).expanduser()
SHARE = Path(helpers.join(LOCAL, "share")).expanduser()
BIN = Path(helpers.join(LOCAL, "bin")).expanduser()
SINGULARIS = Path(os.getcwd()).expanduser()
ASPECTS = Path(helpers.join(SINGULARIS, "aspects")).expanduser()
THIRD_PARTY_TOOLS = Path(helpers.join(
    SINGULARIS, "third-party-tools")).expanduser()
VENDOR = Path(helpers.join(SINGULARIS, "vendor")).expanduser()
MEDIA = Path(helpers.join(SINGULARIS, "media")).expanduser()
MAN = Path(helpers.join(SINGULARIS, "man")).expanduser()
LOG_LEVEL_TXT = Path(helpers.join(MAN, "log_level.txt")).expanduser()
BACKUP = Path(helpers.join(HOME, ".backup")).expanduser()
CONFIG = Path(helpers.join(HOME, ".config")).expanduser()
