#!/usr/bin/env python3

import argparse
import math


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('data', type=argparse.FileType('r'))
    args = parser.parse_args()

    data = parse(args.data)

    print(f"Part one: {part_one(data, 25)}")
    print(f"Part two: {part_two(data, part_one(data, 25))}")


def parse(data):
    return [int(line.strip()) for line in data.readlines()]


def valid(previous, number):
    if math.floor(number / 2) > max(previous) - 1:
        return False

    for i in previous:
        for j in previous:
            if i != j and i + j == number:
                return True


def part_one(data, preamble_size):
    to_test = range(preamble_size, len(data) + 1)

    for index in to_test:
        previous = data[index - preamble_size:index]
        number = data[index]
        if not valid(previous, number):
            return number

def part_two(data, target):
    for start in range(0, len(data) - 1):
        for end in range(start + 1, len(data) - 1):
            sequence = data[start:end+1]
            total = sum(sequence)
            if total == target:
                return min(sequence) + max(sequence)

            if total > target:
                break


if __name__ == '__main__':
    main()
