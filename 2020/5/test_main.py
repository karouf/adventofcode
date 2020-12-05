#!/usr/bin/env python3

import io
import main
import os
import unittest

class TestMain(unittest.TestCase):
    data = """FBFBBFFRLR
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL"""

    def test_seat_id(self):
        data = main.parse(io.StringIO(self.data))
        assert main.seat_id(data[0]) == 357
        assert main.seat_id(data[1]) == 567
        assert main.seat_id(data[2]) == 119
        assert main.seat_id(data[3]) == 820

    def test_part_one(self):
        data = main.parse(io.StringIO(self.data))
        assert main.part_one(data) == 820

    def test_part_two(self):
        input_path = os.path.join(os.path.dirname(__file__), 'input.data')
        with open(input_path) as input_file:
            data = main.parse(input_file)
        assert main.part_two(data) == 524

