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
    return [line.strip().split() for line in data.readlines()]


def run(code, ip, acc):
    op, val = code[ip]
    if op == 'nop':
        return ip + 1, acc
    elif op == 'acc':
        return ip + 1, eval(f"{acc}{val}")
    elif op == 'jmp':
        return ip + int(val), acc


def part_one(data):
    executed = set()
    next = 0
    acc = 0
    while True:
        executed.add(next)
        next, acc = run(data, next, acc)
        if next in executed:
            return acc


def part_two(data):
    pass


if __name__ == '__main__':
    main()
