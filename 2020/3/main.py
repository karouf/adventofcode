#!/usr/bin/env python3

import argparse

slopes = [(1, 1),
          (3, 1),
          (5, 1),
          (7, 1),
          (1, 2)]

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('data', type=argparse.FileType('r'))
    args = parser.parse_args()

    data = parse(args.data)

    print(f"Part one: {part_one(data, slopes[1][0], slopes[1][1])}")
    print(f"Part two: {part_two(data, slopes)}")


def parse(data):
    return [line.strip() for line in data.readlines()]


def part_one(data, slope_x, slope_y):
    pos_x = 0
    pos_y = 0
    width = len(data[0])
    height = len(data)

    trees = 0
    while True:
        pos_x += slope_x
        pos_y += slope_y

        if pos_x >= width:
            pos_x = pos_x - width

        if pos_y >= height:
            break

        if data[pos_y][pos_x] == '#':
            trees += 1
    
    return trees

def part_two(data, slopes):
    trees = 1
    for x, y in slopes:
        trees *= part_one(data, x, y)

    return trees


if __name__ == '__main__':
    main()
