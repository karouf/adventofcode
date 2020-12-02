#!/usr/bin/env python3

expense_report = {int(line) for line in open('1.data').readlines()}

for x in expense_report:
    y = 2020 - x
    if y in expense_report:
        print(x, y, x*y)
        break
