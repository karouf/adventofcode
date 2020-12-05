#!/usr/bin/env python3

import argparse
from collections import defaultdict

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('data', type=argparse.FileType('r'))
    args = parser.parse_args()

    data = parse(args.data)

    print(f"Part one: {part_one(data)}")
    print(f"Part two: {part_two(data)}")


def parse(data):
    return [line.strip() for line in data.readlines()]


def seat_id(code):
    min_row = 0
    max_row = 127
    min_col = 0
    max_col = 7

    for c in code:
        if c == 'F':
            max_row = max_row - (max_row - min_row + 1) / 2
        if c == 'B':
            min_row = min_row + (max_row - min_row + 1) / 2
        if c == 'L':
            max_col = max_col - (max_col - min_col + 1) / 2
        if c == 'R':
            min_col = min_col + (max_col - min_col + 1) / 2

    return min_row * 8 + min_col


def part_one(data):
    return max([seat_id(code) for code in data])


def part_two(data):
    present = {seat_id(code) for code in data}
    seats = set(range(0, 127 * 8 + 7 + 1))
    for id in seats - present:
        if (id - 1) in present and (id + 1) in present:
            return id


if __name__ == '__main__':
    main()
