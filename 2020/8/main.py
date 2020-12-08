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

def detect_loop(code, start, loops):
    executed = set()
    next_ip = start
    acc = 0
    while True:
        if next_ip in executed:
            return True

        if next_ip == len(code):
            return False

        if loops[next_ip] is not None:
            return loops[next_ip]

        executed.add(next_ip)
        next_ip, acc = run(code, next_ip, acc)


def detect_loops(code):
    loops = [None] * len(code)
    i = len(code) - 1
    while i >= 0:
        loops[i] = detect_loop(code, i, loops)
        i -= 1
    return loops


def fix_code(code):
    loops = detect_loops(code)

    executed = set()
    next_ip = 0
    acc = 0
    while True:
        executed.add(next_ip)
        next_ip, acc = run(code, next_ip, acc)
        if next_ip in executed:
            break

    for ip in executed:
        op, val = code[ip]
        if op == 'nop':
            next_ip = ip + int(val)
            if not loops[next_ip]:
                code[ip][0] = 'jmp'
                return code
        elif op == 'jmp':
            next_ip = ip + 1
            if not loops[next_ip]:
                code[ip][0] = 'nop'
                return code
        else:
            continue


def part_one(data):
    executed = set()
    next_ip = 0
    acc = 0
    while True:
        executed.add(next_ip)
        next_ip, acc = run(data, next_ip, acc)
        if next_ip in executed or next_ip == len(data):
            return acc


def part_two(data):
    return part_one(fix_code(data))


if __name__ == '__main__':
    main()
