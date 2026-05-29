"""Renumber figure captions sequentially in an RST file.

Usage: python3 renumber_figures.py <file.rst>
"""

import re
import sys


def renumber_figures(path: str) -> None:
    with open(path, 'r') as f:
        lines = f.readlines()

    counter = 0
    new_lines = []

    for line in lines:
        if re.match(r'^\s*\|?\s*\*\d+\s+pav\.', line):
            counter += 1
            line = re.sub(r'\*(\d+)\s+pav\.', f'*{counter} pav.', line, count=1)
        new_lines.append(line)

    with open(path, 'w') as f:
        f.writelines(new_lines)

    print(f"Renumbered {counter} figures in {path}")


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <file.rst>")
        sys.exit(1)
    renumber_figures(sys.argv[1])
