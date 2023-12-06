#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative 'main'
require 'stringio'

class TestMain < Minitest::Test
  DATA = <<~DATA
  Time:      7  15   30
  Distance:  9  40  200
  DATA

  def test_part_one
    main = Main.new(StringIO.new(DATA).readlines.map(&:strip))
    assert_equal 288, main.part_one
  end

  def test_part_two
    main = Main.new(StringIO.new(DATA).readlines.map(&:strip))
    assert_equal 71503, main.part_two
  end

  def test_part_one_for_real
    input_path = File.join(File.dirname(__FILE__), 'input.data')
    File.open(input_path) do |input_file|
      main = Main.new(input_file.readlines.map(&:strip))
      assert_equal 170000, main.part_one
    end
  end

  def test_part_two_for_real
    input_path = File.join(File.dirname(__FILE__), 'input.data')
    File.open(input_path) do |input_file|
      main = Main.new(input_file.readlines.map(&:strip))
      assert_equal 20537782, main.part_two
    end
  end
end

