#!/usr/bin/env python3

import io
import main
import unittest

class TestMain(unittest.TestCase):
    data = """
"""

    def test_part_one(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.part_one(data), 1337)

    @unittest.skip('Wait for part one to be done')
    def test_part_two(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.part_two(data), 42)

    @unittest.skip('Wait for part one to be done')
    def test_part_one_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_one(data), 58)

    @unittest.skip('Wait for part two to be done')
    def test_part_two_for_real(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        self.assertEqual(main.part_two(data), 23)
