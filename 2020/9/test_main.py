#!/usr/bin/env python3

import io
import main
import os
import unittest

class TestMain(unittest.TestCase):
    data = """35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576"""

    data2 = """35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576"""

    def test_part_one(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.part_one(data, 5), 127)

    def test_valid_number(self):
        previous = list(range(1,26))
        self.assertEqual(main.valid(previous, 26), True)
        self.assertEqual(main.valid(previous, 49), True)
        self.assertEqual(main.valid(previous, 100), False)
        self.assertEqual(main.valid(previous, 50), False)

    def test_part_two(self):
        data = main.parse(io.StringIO(self.data2))
        self.assertEqual(main.part_two(data, 127), 62)

    def test_part_one_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_one(data, 25), 29221323)

    def test_part_two_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_two(data, 29221323), 4389369)
