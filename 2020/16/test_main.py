#!/usr/bin/env python3

import io
import main
import os
import unittest

class TestMain(unittest.TestCase):
    data = """class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12"""

    data2 = """class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
3,9,18
15,1,5
5,14,9"""

    def test_part_one(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.part_one(data), 71)

    def test_part_two(self):
        data = main.parse(io.StringIO(self.data2))
        self.assertEqual(main.part_two(data, ['class', 'seat']), 12*13)

    def test_part_one_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_one(data), 27898)

    def test_part_two_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_two(data), 2766491048287)
