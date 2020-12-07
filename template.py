#!/usr/bin/env python3

import argparse


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('data', type=argparse.FileType('r'))
    args = parser.parse_args()

    data = parse(args.data)

    print(f"Part one: {part_one(data)}")
    print(f"Part two: {part_two(data)}")


def parse(data):
    return [line.strip() for line in data.readlines()]


def part_one(data):
    pass


def part_two(data):
    pass


if __name__ == '__main__':
    main()
