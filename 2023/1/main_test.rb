#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative 'main'
require 'stringio'

class TestMain < Minitest::Test
  DATA1 = <<~DATA
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
DATA

  DATA2 = <<~DATA
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
aaaaaoneaaaaa
aaaaaaaaaaaaa
aaaaaa1aaaaaa
aa1aaaaaaa2aa
nineqtdtmmpjpkzpxmmfive83sevenseventhree
sevenine
oneone
DATA

  def test_part_one
    main = Main.new(StringIO.new(DATA1))
    assert_equal 142, main.part_one
  end

  def test_part_two
    main = Main.new(StringIO.new(DATA2))
    assert_equal 498, main.part_two
  end

  def test_part_one_for_real
    input_path = File.join(File.dirname(__FILE__), 'input.data')
    File.open(input_path) do |input_file|
      main = Main.new(input_file.readlines.map(&:strip))
      assert_equal 55108, main.part_one
    end
  end

  def test_part_two_for_real
    skip 'Wait for part two to be done'
    input_path = File.join(File.dirname(__FILE__), 'input.data')
    File.open(input_path) do |input_file|
      main = Main.new(input_file.readlines.map(&:strip))
      assert_equal 23, main.part_two
    end
  end
end

