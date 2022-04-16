#!/usr/bin/python

import csv
import sys

help_text = """
    CSV Column reader - Extract a column out of a CSV.
    Usage: csv_column.py [CSV path] [Column #]
    Example: csv_column.py ./csv_file.csv 3
"""


d = str(sys.argv[1])

if d in ["--help", "-h"]:
    print(help_text)

column = int(sys.argv[2])

with open(d, 'r') as opn:
    data = []
    reader = csv.reader(opn)
    for row in reader:
        data += [row[column]]

    for i in data:
        print(i)

