import man.variables as variables


class InitClass:
    def __init__(self):
        self.home_dir = variables.HOME
        self.singularis_dir = variables.SINGULARIS
        self.aspects_dir = variables.ASPECTS
        self.third_party_tools_dir = variables.THIRD_PARTY_TOOLS
        self.vendor_dir = variables.VENDOR
        self.media_dir = variables.MEDIA
        self.local_dir = variables.LOCAL
        self.backup_dir = variables.BACKUP
        self.config_dir = variables.CONFIG
        self.man_dir = variables.MAN
        self.log_level_txt = variables.LOG_LEVEL_TXT
        self.types = [".home", ".config", ".local"]
