#!/usr/bin/env python3

import re

data_format = '(\d+)-(\d+) ([a-z]): ([a-z]+)'
data = open('2.data').readlines()

ok = []
for d in data:
    low, high, token, passwd = re.match(data_format, d).groups()

    low = int(low)
    high = int(high) + 1
    matches = re.findall(token, passwd)

    if len(matches) in range(low, high):
        ok.append(d)

print(len(ok))
