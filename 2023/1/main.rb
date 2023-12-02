#!/usr/bin/env ruby

require 'optparse'

class Main
  def initialize(data)
    @data = data
  end

  def part_one
    @data.map do |line|
      digits = line.chars.select { |c| c =~ /\d/ }
      [digits.first.to_s, digits.last.to_s].join.to_i
    end.sum
  end

  def part_two
    # list all single digit numbers spelled out in a constant
    numbers = %w[one two three four five six seven eight nine 1 2 3 4 5 6 7 8 9]
    mapping = {
      'one' => '1',
      'two' => '2',
      'three' => '3',
      'four' => '4',
      'five' => '5',
      'six' => '6',
      'seven' => '7',
      'eight' => '8',
      'nine' => '9'
    }

    return @data.map do |line|
      left_found = numbers.map do |n|
        [n, line.index(n)]
      end.reject{|r| r.last.nil?}.min_by{|m| m.last }.first
      right_found = numbers.map do |n|
        [n, line.rindex(n)]
      end.reject{|r| r.last.nil?}.max_by{|m| m.last }.first

      left = mapping[left_found] || left_found
      right = mapping[right_found] || right_found

      total = left + right
      total.to_i
    end.sum
  end
end

def main
  options = {}
  OptionParser.new do |parser|
    parser.on('-d', '--data DATA', 'Input data file')
  end.parse!(into: options)

  main = Main.new(File.readlines(options[:data]).map(&:strip))

  puts "Part one: #{main.part_one}"
  puts "Part two: #{main.part_two}"
end

main if __FILE__ == $0
