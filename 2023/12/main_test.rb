#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative 'main'
require 'stringio'

class TestMain < Minitest::Test
  DATA = <<~DATA
  ???.### 1,1,3
  .??..??...?##. 1,1,3
  ?#?#?#?#?#?#?#? 1,3,1,6
  ????.#...#... 4,1,1
  ????.######..#####. 1,6,5
  ?###???????? 3,2,1
  DATA

  def test_part_one
    main = Main.new(StringIO.new(DATA).readlines.map(&:strip))
    assert_equal 21, main.part_one
  end

  def test_part_two
    skip 'Wait for part one to be done'
    main = Main.new(StringIO.new(DATA).readlines.map(&:strip))
    assert_equal 42, main.part_two
  end

  def test_part_one_for_real
    input_path = File.join(File.dirname(__FILE__), 'input.data')
    File.open(input_path) do |input_file|
      main = Main.new(input_file.readlines.map(&:strip))
      assert_equal 7599, main.part_one
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

