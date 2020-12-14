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
    return [line.strip() for line in data.readlines()]


def part_one(data):
    memory = defaultdict(int)

    for command in data:
        if 'mask' in command:
            bitmask = command.split(' = ')[1].strip()

        if 'mem' in command:
            address, value = command.split(' = ')
            address = address.split('[')[1].replace(']', '')
            value = bin(int(value)).replace('0b', '').zfill(36)

            new_value = ''
            for i, b in enumerate(value):
                if bitmask[i] == 'X':
                    new_value += b
                else:
                    new_value += bitmask[i]

            memory[address] = int(new_value, base=2)

    return sum(memory.values())
            

def get_addresses(mask):
    addresses = []
    num_x = len([b for b in mask if b == 'X'])
    num_addr = pow(2, num_x)
    wildcards = [list(bin(b).replace('0b', '').zfill(num_x)) for b in range(0, num_addr)]

    for wildcard in wildcards:
        addr = ''
        for i, b in enumerate(mask):
            if b == 'X':
                addr += wildcard.pop(0)
            else:
                addr += b
        addresses.append(addr)
    return addresses

            
def part_two(data):
    memory = defaultdict(int)

    for command in data:
        if 'mask' in command:
            bitmask = command.split(' = ')[1].strip()

        if 'mem' in command:
            address, value = command.split(' = ')
            address = address.split('[')[1].replace(']', '')
            address = bin(int(address)).replace('0b', '').zfill(36)
            value = int(value)

            new_value = ''
            for i, b in enumerate(address):
                if bitmask[i] == '0':
                    new_value += b
                else:
                    new_value += bitmask[i]

            for addr in get_addresses(new_value):
            	memory[addr] = value

    return sum(memory.values())


if __name__ == '__main__':
    main()
