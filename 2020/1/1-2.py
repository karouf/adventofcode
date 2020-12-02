#!/usr/bin/env python3

expense_report = [int(line) for line in open('1.data').readlines()]

found = False
for x in expense_report:
    for y in [y for y in expense_report if y != x]:
        z = 2020 - x - y

        if z in expense_report:
            print(x, y, z, x*y*z)
            found = True
            break

    if found:
        break
