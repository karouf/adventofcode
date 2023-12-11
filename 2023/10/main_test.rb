#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative 'main'
require 'stringio'

class TestMain < Minitest::Test
  DATA = <<~DATA
  -L|F7
  7S-7|
  L|7||
  -L-J|
  L|-JF
  DATA

  DATA2 = <<~DATA
  7-F7-
  .FJ|7
  SJLL7
  |F--J
  LJ.LJ
  DATA

  DATA3 = <<~DATA
  ...........
  .S-------7.
  .|F-----7|.
  .||.....||.
  .||.....||.
  .|L-7.F-J|.
  .|..|.|..|.
  .L--J.L--J.
  ...........
  DATA

  DATA4 = <<~DATA
  .F----7F7F7F7F-7....
  .|F--7||||||||FJ....
  .||.FJ||||||||L7....
  FJL7L7LJLJ||LJ.L-7..
  L--J.L7...LJS7F-7L7.
  ....F-J..F7FJ|L7L7L7
  ....L7.F7||L7|.L7L7|
  .....|FJLJ|FJ|F7|.LJ
  ....FJL-7.||.||||...
  ....L---J.LJ.LJLJ...
  DATA

  def test_part_one
    main = Main.new(StringIO.new(DATA).readlines.map(&:strip))
    assert_equal 4, main.part_one
    main = Main.new(StringIO.new(DATA2).readlines.map(&:strip))
    assert_equal 8, main.part_one
  end

  def test_part_two
    main = Main.new(StringIO.new(DATA3).readlines.map(&:strip))
    assert_equal 4, main.part_two
    main = Main.new(StringIO.new(DATA4).readlines.map(&:strip))
    assert_equal 10, main.part_two
  end

  def test_part_one_for_real
    skip 'Wait for part two to be done'
    input_path = File.join(File.dirname(__FILE__), 'input.data')
    File.open(input_path) do |input_file|
      main = Main.new(input_file.readlines.map(&:strip))
      assert_equal 7012, main.part_one
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

