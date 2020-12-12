#!/usr/bin/env python3

import io
import main
import os
import unittest

class TestMain(unittest.TestCase):
    data = """F10
N3
F7
R90
F11"""

    def test_part_one(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.part_one(data), 25)

    def test_part_two(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.part_two(data), 286)

    def test_part_one_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_one(data), 2270)

    def test_part_two_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_two(data), 138669)
