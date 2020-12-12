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
    return [(line.strip()[0], int(line.strip()[1:])) for line in data.readlines()]

class Ship():
    def __init__(self):
        self.direction = 'E'
        self.north = 0
        self.east = 0
        self.south = 0
        self.west = 0

    def control(self, command, value):
        if command in 'NSEW':
            self.move(command, value)
        elif command in 'LR':
            self.turn(command, value)
        elif command == 'F':
            self.forward(value)

    def move(self, cape, value):
        if cape == 'N':
            self.north += value
            self.south -= value
        if cape == 'S':
            self.south += value
            self.north -= value
        if cape == 'E':
            self.east += value
            self.west -= value
        if cape == 'W':
            self.west += value
            self.east -= value

    def turn(self, side, angle):
        turns = angle / 90
        if side == 'R':
            directions = 'NESW'
        else:
            directions = 'NWSE'
        current = directions.index(self.direction)
        new = int((current + turns) % 4)
        self.direction = directions[new]

    def forward(self, value):
        self.move(self.direction, value)

    def distance(self):
        return max([self.north, self.south]) + max([self.east, self.west])


class Ship2():
    def __init__(self):
        self.waypoint = {'N': 1, 'E': 10, 'S': -1, 'W': -10}
        self.north = 0
        self.east = 0
        self.south = 0
        self.west = 0

    def control(self, command, value):
        if command in 'NSEW':
            self.move(command, value)
        elif command in 'LR':
            self.turn(command, value)
        elif command == 'F':
            self.forward(value)

    def move(self, cape, value):
        opposite = {'N': 'S', 'S': 'N', 'E': 'W', 'W': 'E'}
        self.waypoint[cape] += value
        self.waypoint[opposite[cape]] -= value

    def turn(self, side, angle):
        turns = angle / 90
        if side == 'R':
            directions = 'NESW'
        else:
            directions = 'NWSE'

        new_waypoint = self.waypoint.copy()
        for direction in directions:
            current = directions.index(direction)
            new = int((current + turns) % 4)
            new_waypoint[directions[new]] = self.waypoint[directions[current]]
        self.waypoint = new_waypoint

    def forward(self, value):
        for n in range(0,value):
            if self.waypoint['N'] > self.waypoint['S']:
                self.north += self.waypoint['N']
                self.south -= self.waypoint['N']
            else:
                self.south += self.waypoint['S']
                self.north -= self.waypoint['S']

            if self.waypoint['E'] > self.waypoint['W']:
                self.east += self.waypoint['E']
                self.west -= self.waypoint['E']
            else:
                self.west += self.waypoint['W']
                self.east -= self.waypoint['W']

    def distance(self):
        return max([self.north, self.south]) + max([self.east, self.west])


def part_one(data):
    ship = Ship()
    for command, value in data:
        ship.control(command, value)
    return ship.distance()


def part_two(data):
    ship = Ship2()
    for command, value in data:
        ship.control(command, value)
    return ship.distance()


if __name__ == '__main__':
    main()
