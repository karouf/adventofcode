#!/usr/bin/env python3

import io
import main
import os
import unittest

class TestMain(unittest.TestCase):
    data = """939
7,13,x,x,59,x,31,19"""

    def test_part_one(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.part_one(data), 295)

    def test_part_two(self):
        data = main.parse(io.StringIO('1\n17,x,13,19'))
        self.assertEqual(main.part_two(data), 3417)
        data = main.parse(io.StringIO('1\n67,7,59,61'))
        self.assertEqual(main.part_two(data), 754018)
        data = main.parse(io.StringIO('1\n67,x,7,59,61'))
        self.assertEqual(main.part_two(data), 779210)
        data = main.parse(io.StringIO('1\n67,7,x,59,61'))
        self.assertEqual(main.part_two(data), 1261476)
        data = main.parse(io.StringIO('1\n1789,37,47,1889'))
        self.assertEqual(main.part_two(data), 1202161486)

    def test_part_one_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_one(data), 207)

    def test_part_two_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_two(data), 530015546283687)
