#!/usr/bin/env python3

import argparse
import re

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('data', type=argparse.FileType('r'))
    args = parser.parse_args()

    data = parse(args.data)

    print(f"Part one: {part_one(data)}")
    print(f"Part two: {part_two(data)}")


def parse(data):
    passports = []
    for record in data.read().split('\n\n'):
        passport = {}
        for field in record.split():
            key, value = field.split(':')
            passport[key] = value
        passports.append(passport)

    return passports


def valid_passport(record):
    required_fields = ['ecl', 'pid', 'eyr', 'hcl', 'byr', 'iyr', 'hgt']
    return all([f in record.keys() for f in required_fields])

def valid_field_data(data):
    for key, value in data.items():
        if key == 'byr':
            if not re.match('^\d{4}$', value):
                return False
            if not (1920 <= int(value) <= 2002):
                return False
        elif key == 'iyr':
            if not re.match('^\d{4}$', value):
                return False
            if not (2010 <= int(value) <= 2020):
                return False
        elif key == 'eyr':
            if not re.match('^\d{4}$', value):
                return False
            if not (2020 <= int(value) <= 2030):
                return False
        elif key == 'hgt':
            matches = re.match('^(\d+)(cm|in)$', value)
            if not matches:
                return False
            height, unit = matches.groups()
            if unit == 'cm' and not (150 <= int(height) <= 193):
                return False
            if unit == 'in' and not (59 <= int(height) <= 76):
                return False
        elif key == 'hcl':
            if not re.match('^#[0-9a-f]{6}$', value):
                return False
        elif key == 'ecl':
            if value not in ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']:
                return False
        elif key == 'pid':
            if not re.match('^\d{9}$', value):
                return False

    return True


def part_one(data):
    return len([passport for passport in data if valid_passport(passport)])

def part_two(data):
    valid =  [passport for passport in data if valid_passport(passport)]
    valid = [passport for passport in valid if valid_field_data(passport)]
    return len(valid)

if __name__ == '__main__':
    main()
