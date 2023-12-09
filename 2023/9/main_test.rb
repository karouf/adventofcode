#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative 'main'
require 'stringio'

class TestMain < Minitest::Test
  DATA = <<~DATA
  0 3 6 9 12 15
  1 3 6 10 15 21
  10 13 16 21 30 45
  DATA

  def test_part_one
    main = Main.new(StringIO.new(DATA).readlines.map(&:strip))
    assert_equal 114, main.part_one
  end

  def test_part_two
    main = Main.new(StringIO.new(DATA).readlines.map(&:strip))
    assert_equal 2, main.part_two
  end

  def test_part_one_for_real
    input_path = File.join(File.dirname(__FILE__), 'input.data')
    File.open(input_path) do |input_file|
      main = Main.new(input_file.readlines.map(&:strip))
      assert_equal 1938800261, main.part_one
    end
  end

  def test_part_two_for_real
    input_path = File.join(File.dirname(__FILE__), 'input.data')
    File.open(input_path) do |input_file|
      main = Main.new(input_file.readlines.map(&:strip))
      assert_equal 1112, main.part_two
    end
  end
end

