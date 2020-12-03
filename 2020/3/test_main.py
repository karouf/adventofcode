#!/usr/bin/env python3

import unittest
import main
import io

class TestMain(unittest.TestCase):
    data = """..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#"""

    slopes = [(1, 1),
              (3, 1),
              (5, 1),
              (7, 1),
              (1, 2)]

    def test_part_one(self):
        data = main.parse(io.StringIO(self.data))
        x = self.slopes[1][0]
        y = self.slopes[1][1]
        assert main.part_one(data, x, y) == 7

    def test_part_two(self):
        data = main.parse(io.StringIO(self.data))
        assert main.part_two(data, self.slopes) == 336

