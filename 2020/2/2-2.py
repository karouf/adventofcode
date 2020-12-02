#!/usr/bin/env python3

import re

data_format = '(\d+)-(\d+) ([a-z]): ([a-z]+)'
data = open('2.data').readlines()

ok = []
for d in data:
    first, second, token, passwd = re.match(data_format, d).groups()

    first = int(first) - 1
    second = int(second) - 1

    try:
        found_first = passwd[first] == token
    except:
        found_first = False

    try:
        found_second = passwd[second] == token
    except:
        found_second = False

    if found_first != found_second:
        ok.append(d)

print(len(ok))
