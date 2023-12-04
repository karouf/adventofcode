#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative 'main'
require 'stringio'

class TestMain < Minitest::Test
  DATA = <<~DATA
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  ........*.
  24$..4....
DATA

  DATA2 = <<~DATA
  .......................*......*
  ...910*...............233..189.
  2......391.....789*............
  ...................983.........
  0........106-...............226
  .%............................$
  ...*......$812......812..851...
  .99.711.............+.....*....
  ...........................113.
  28*.....411....%...............
  DATA

  def test_part_one
    main = Main.new(StringIO.new(DATA).readlines.map(&:strip))
    assert_equal 4385, main.part_one
    main = Main.new(StringIO.new(DATA2).readlines.map(&:strip))
    assert_equal 7253, main.part_one
  end

  def test_part_two
    main = Main.new(StringIO.new(DATA).readlines.map(&:strip))
    assert_equal 467835, main.part_two
  end

  def test_part_one_for_real
    input_path = File.join(File.dirname(__FILE__), 'input.data')
    File.open(input_path) do |input_file|
      main = Main.new(input_file.readlines.map(&:strip))
      assert_equal 530495, main.part_one
    end
  end

  def test_part_two_for_real
    input_path = File.join(File.dirname(__FILE__), 'input.data')
    File.open(input_path) do |input_file|
      main = Main.new(input_file.readlines.map(&:strip))
      assert_equal 80253814, main.part_two
    end
  end
end

