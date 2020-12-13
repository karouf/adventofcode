#!/usr/bin/env python3

import argparse
import math


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
    t = int(data[0])
    buses = [int(b) for b in data[1].split(',') if b != 'x']
    departures = {}

    for bus in buses:
        departure = math.ceil(t / bus) * bus
        departures[departure] = bus

    closest = min(departures)
    return (closest - t) * departures[closest]


def part_two(data):
    data = data[1].split(',')
    t = 0
    first = data[0]
    last = data[-1]
    increment = int(first)
    found = False
    buses = {bus: False for bus in data if bus != 'x'}

    while not found:
        t = t + increment

        for index, bus in enumerate(data):
            if bus != first and bus != 'x':
                if ((t + index) % int(bus)) == 0:
                    if not buses[bus]:
                        increment *= int(bus)
                        buses[bus] = True

                    if bus == last:
                        found = True
                        break
                else:
                    break
    return t


if __name__ == '__main__':
    main()
