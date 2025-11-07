from itertools import cycle
from shutil import get_terminal_size
from threading import Thread
from time import sleep

from man.log import Log as Log

log = Log()


class Loader:
    def __init__(self, log_function, failure_function, log_level=3):
        self.timeout = 0.1
        self.success_function = log_function
        self.failure_function = failure_function
        self.log_level = log_level

        self._thread = Thread(target=self._animate, daemon=True)
        self.steps = ["⢿", "⣻", "⣽", "⣾", "⣷", "⣯", "⣟", "⡿"]
        self.done = False

    def start(self, desc):
        self.desc = desc
        self._thread.start()
        return self

    def _animate(self):
        for c in cycle(self.steps):
            if self.done:
                break
            if self.log_level >= 3:
                print(f"\r{self.desc} {c}", flush=True, end="")
                sleep(self.timeout)

    def __enter__(self, desc):
        self.start(desc)

    def success(self, end):
        self.done = True
        cols = get_terminal_size((80, 20)).columns
        print("\r" + " " * cols, end="\r")
        self.success_function(end)

    def failure(self, end=""):
        self.done = True
        cols = get_terminal_size((80, 20)).columns
        print("\r" + " " * cols, end="\r")
        self.failure_function(end)
