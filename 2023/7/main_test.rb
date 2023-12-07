#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative 'main'
require 'stringio'

class TestMain < Minitest::Test
  DATA = <<~DATA
  32T3K 765
  T55J5 684
  KK677 28
  KTJJT 220
  QQQJA 483
  DATA

  def test_part_one
    main = Main.new(StringIO.new(DATA).readlines.map(&:strip))
    assert_equal 6440, main.part_one
  end

  def test_part_two
    main = Main.new(StringIO.new(DATA).readlines.map(&:strip))
    assert_equal 5905, main.part_two
  end

  def test_part_one_for_real
    input_path = File.join(File.dirname(__FILE__), 'input.data')
    File.open(input_path) do |input_file|
      main = Main.new(input_file.readlines.map(&:strip))
      assert_equal 253603890, main.part_one
    end
  end

  def test_part_two_for_real
    input_path = File.join(File.dirname(__FILE__), 'input.data')
    File.open(input_path) do |input_file|
      main = Main.new(input_file.readlines.map(&:strip))
      assert_equal 253630098, main.part_two
    end
  end
end

