#!/usr/bin/env bash

import man.helpers as helpers

import os.path as path

HOME = path.expanduser("~")
SINGULARIS = helpers.join(HOME, "Singularis", seperator="/")

ASPECTS = helpers.join(SINGULARIS, "config", seperator="/")
THIRD_PARTY_TOOLS = helpers.join(
    SINGULARIS, "third-party-tools", seperator="/")
VENDOR = helpers.join(SINGULARIS, "vendor", seperator="/")
MEDIA = helpers.join(SINGULARIS, "media", seperator="/")
LOCAL = helpers.join(SINGULARIS, "local", seperator="/")
BACKUP = helpers.join(HOME, ".backup", seperator="/")
CONFIG = helpers.join(HOME, ".config", seperator="/")

###############
#  Templates  #
###############

COMMIT = """[commit]
    gpgSign = true
    template = ~/.config/git/gitmessage.txt
"""
USER = """[user]
    email = singularisartt@gmail.com
    name = Hashem A. Damrah
"""
CREDENTIAL = """[credential]
    helper = store
"""
GITHUB = """[github]
    username = SingularisArt
"""
