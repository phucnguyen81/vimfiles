#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Colorize the current line in the preview window in bold red."""

import shutil
import sys

LINE = int(sys.argv[1])
FILE = sys.argv[2]

# Use a large default for width since the extra doesn't get displayed anyway
width = max(1, shutil.get_terminal_size().lines // 2)
end_width = 200

# file numbers start at 1
beginning = max(1, LINE - width)
end = LINE + end_width

# ANSI escape sequences for coloring matched line
RED = "\033[1;31m"
RESET = "\033[0;0m"
BOLD = "\033[;1m"

if __name__ == "__main__":
    with open(FILE, encoding="utf-8") as f:
        for linenum, line_content in enumerate(f, start=1):
            if beginning <= linenum <= end:
                if linenum == LINE:
                    print(BOLD + RED + line_content.rstrip() + RESET)
                else:
                    print(line_content.rstrip())
