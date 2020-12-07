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

    def test_part_two(self):
        data = main.parse(io.StringIO(self.data))
        self.assertEqual(main.part_two(data), 42)

