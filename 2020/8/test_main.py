#!/usr/bin/env python3

import io
import main
import os
import unittest

class TestMain(unittest.TestCase):
    data = """nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6"""

    def test_part_one(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.part_one(data), 5)

    def test_part_two(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.part_two(data), 8)

    def test_part_one_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_one(data), 1782)

    def test_part_two_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_two(data), 797)
