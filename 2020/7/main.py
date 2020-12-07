#!/usr/bin/env python3

import argparse
from collections import defaultdict


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('data', type=argparse.FileType('r'))
    args = parser.parse_args()

    data = parse(args.data)

    print(f"Part one: {part_one(data[0], 'shiny gold')}")
    print(f"Part two: {part_two(data[1], 'shiny gold')}")


def parse(data):
    rules = [line.strip() for line in data.readlines()]
    outer_lookup = defaultdict(set)
    inner_lookup = defaultdict(dict)
    for rule in rules:
        outer, inners = rule.split(' bags contain ')

        if 'no other bags' in inners:
            continue

        inners = inners.split(', ')

        for inner in inners:
            if 'bags' in inner:
                inner = inner.replace(' bags', '')
            else:
                inner = inner.replace(' bag', '')
            inner = inner.replace('.', '')
            number, saturation, hue = inner.split(' ')
            color = f'{saturation} {hue}'
            outer_lookup[color].add(outer)
            inner_lookup[outer][color] = int(number)
    return outer_lookup, inner_lookup


def lookup_outer_bags(data, color):
    outers = data[color]
    for outer in outers:
        outers = outers.union(lookup_outer_bags(data, outer))
    return outers


def lookup_inner_bags(data, color):
    inners = data[color]
    total = 0
    if inners:
        for bag, number in inners.items():
            inner_number = number * lookup_inner_bags(data, bag)
            total += number + inner_number
    return total


def part_one(data, bag_color):
    return len(lookup_outer_bags(data, bag_color))


def part_two(data, bag_color):
    return lookup_inner_bags(data, bag_color)


if __name__ == '__main__':
    main()
