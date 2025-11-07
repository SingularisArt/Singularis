class Colors:

    def __init__(self):
        ########################
        # Background variables #
        ########################

        self.bg = {
            "black": "\033[40m",
            "red": "\033[41m",
            "green": "\033[42m",
            "orange": "\033[43m",
            "yellow": "\033[43m",
            "blue": "\033[44m",
            "purple": "\033[45m",
            "cyan": "\033[46m",
            "white": "\033[47m",
        }

        ###################
        # Color variables #
        ###################

        self.fg = {
            "black": "\033[30m",
            "white": "\033[1;37m",
            "red": "\033[0;31m",
            "blue": "\033[34m",
            "green": "\033[0;32m",
            "cyan": "\033[0;36m",
            "purple": "\033[0;35m",
            "orange": "\033[0;33m",
            "yellow": "\033[1;33m",
            "pink": "\033[95m",
        }

        ###################
        # Style variables #
        ###################

        self.style = {
            "reset": "\033[0m",
            "bold": "\033[01m",
            "disable": "\033[02m",
            "underline": "\033[04m",
            "reverse": "\033[07m",
            "strikethrough": "\033[09m",
            "invisible": "\033[08m",
        }
