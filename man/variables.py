import os
from pathlib import Path

import man.helpers as helpers

HOME = Path(os.path.expanduser("~")).expanduser()
LOCAL = Path(helpers.join(HOME, ".local")).expanduser()
SHARE = Path(helpers.join(LOCAL, "share")).expanduser()
BIN = Path(helpers.join(LOCAL, "bin")).expanduser()
SINGULARIS = Path(os.getcwd()).expanduser()
ASPECTS = Path(helpers.join(SINGULARIS, "aspects")).expanduser()
THIRD_PARTY_TOOLS = Path(helpers.join(SINGULARIS, "third-party-tools")).expanduser()
VENDOR = Path(helpers.join(SINGULARIS, "vendor")).expanduser()
MEDIA = Path(helpers.join(SINGULARIS, "media")).expanduser()
MAN = Path(helpers.join(SINGULARIS, "man")).expanduser()
LOG_LEVEL_TXT = Path(helpers.join(MAN, "log_level.txt")).expanduser()
BACKUP = Path(helpers.join(HOME, ".backup")).expanduser()
CONFIG = Path(helpers.join(HOME, ".config")).expanduser()

home_dir = Path(os.path.expanduser("~")).expanduser()
local_dir = Path(helpers.join(home_dir, ".local")).expanduser()
share_dir = Path(helpers.join(local_dir, "share")).expanduser()
bin_dir = Path(helpers.join(local_dir, "bin")).expanduser()
singularis_dir = Path(os.getcwd()).expanduser()
aspects_dir = Path(helpers.join(singularis_dir, "aspects")).expanduser()
man_dir = Path(helpers.join(singularis_dir, "man")).expanduser()
log_level_txt = Path(helpers.join(man_dir, "log_level.txt")).expanduser()
backup_dir = Path(helpers.join(home_dir, ".backup")).expanduser()
config_dir = Path(helpers.join(home_dir, ".config")).expanduser()
types = [".home", ".config", ".local"]
