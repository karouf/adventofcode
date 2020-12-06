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
    groups = []
    for group in data.read().split('\n\n'):
        persons = [person for person in group.split()]
        groups.append(persons)

    return groups


def any_yes(group):
    answers = set()
    for person in group:
        for answer in person:
            answers.add(answer)
    return len(answers)


def all_yes(group):
    if len(group) == 1:
        return len(group[0])

    first = set(group.pop())
    return len(first.intersection(*group))


def part_one(data):
    return sum([any_yes(group) for group in data])


def part_two(data):
    return sum([all_yes(group) for group in data])


if __name__ == '__main__':
    main()
