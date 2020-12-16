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
    puzzle_input = {'rules': dict()}

    rules, yours, nearby = data.read().split('\n\n')

    for line in rules.split('\n'):
        field, ranges = line.split(': ')
        ranges = ranges.split(' or ')
        ranges = [[int(i) for i in r.split('-')] for r in ranges]
        puzzle_input['rules'][field] = ranges

    puzzle_input['yours'] = [int(i) for i in yours.strip().split('\n')[1].split(',')]
    puzzle_input['nearby'] = [[int(i) for i in t.split(',')] for t in nearby.strip().split('\n')[1:]]

    return puzzle_input


def get_invalid_fields(rules, ticket):
    invalid_fields = []

    for number in ticket:
        any_valid = False

        for specs in rules.values():
            if matches_specs(specs, number):
                any_valid = True

        if not any_valid:
            invalid_fields.append(number)

    return invalid_fields


def matches_specs(specs, number):
    valid = False

    for spec in specs:
        if spec[0] <= number <= spec[1]:
            valid = True

    return valid


def part_one(data):
    total = 0

    for ticket in data['nearby']:
        total += sum(get_invalid_fields(data['rules'], ticket))

    return total


def part_two(data, fields=None):
    if not fields:
        fields = [f for f in data['rules'] if f.startswith('departure')]

    fields_map = defaultdict(list)
    valid_tickets = [t for t in data['nearby'] if not get_invalid_fields(data['rules'], t)]

    for index in range(0, len(data['nearby'][0])):
        for field, specs in data['rules'].items():
            all_valid = True

            for ticket in valid_tickets:
                if not matches_specs(specs, ticket[index]):
                    all_valid = False
                    break

            if all_valid:
                fields_map[field].append(index)
    
    while [i for i in fields_map.values() if len(i) > 1]:
        for found_index in [i[0] for f, i in fields_map.items() if len(i) == 1]:
            for field in [f for f, i in fields_map.items() if len(i) > 1]:
                try:
                    fields_map[field].remove(found_index)
                except:
                    pass
    total = 1
    for field in fields:
        total *= data['yours'][fields_map[field][0]]

    return total


if __name__ == '__main__':
    main()
