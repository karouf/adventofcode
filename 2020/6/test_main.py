#!/usr/bin/env python3

import io
import main
import os
import unittest

class TestMain(unittest.TestCase):
    data = """abc

a
b
c

ab
ac

a
a
a
a

b"""

    def test_any_yes(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.any_yes(data[0]), 3)
        self.assertEqual(main.any_yes(data[1]), 3)
        self.assertEqual(main.any_yes(data[2]), 3)
        self.assertEqual(main.any_yes(data[3]), 1)
        self.assertEqual(main.any_yes(data[4]), 1)

    def test_all_yes(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.all_yes(data[0]), 3)
        self.assertEqual(main.all_yes(data[1]), 0)
        self.assertEqual(main.all_yes(data[2]), 1)
        self.assertEqual(main.all_yes(data[3]), 1)
        self.assertEqual(main.all_yes(data[4]), 1)

    def test_part_one(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.part_one(data), 11)

    def test_part_one_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_one(data), 6583)

    def test_part_two(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.part_two(data), 6)

    def test_part_two_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_two(data), 3290)
