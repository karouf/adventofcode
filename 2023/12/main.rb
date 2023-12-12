#!/usr/bin/env ruby

require 'optparse'

class Main
  def initialize(data)
    @data = data
  end

  def part_one
    data = @data.map do |line|
      pattern, counts = line.split(' ')
      [pattern, counts.split(',').map(&:to_i)]
    end

    data.map do |pattern, counts|
      min_length = counts.sum + counts.length - 1
      row_length = pattern.length
      required_spaces = counts.length - 1
      slack = row_length - min_length
      space_groups = (counts.length + 1).times.map do |i|
        if i == 0 || i == counts.length
          start = 0
        else
          start = 1
        end
        (start..(start + slack)).to_a
      end

      spaces_arrangements = space_groups[0].product(*space_groups[1...]).select { |i| i.sum == (required_spaces + slack) }

      arrangements = spaces_arrangements.map do |spaces_arrangement|
        spaces_arrangement.to_enum.with_index.reduce([]) do |a, (spaces, index)|
          a << '.' * spaces
          a << '#' * counts[index] if counts[index]
          a
        end
      end.map(&:join)

      fit = arrangements.select do |a|
        a.each_char.with_index.all? do |c, i|
          c == pattern[i] || pattern[i] == '?'
        end
      end

      fit.length
    end.sum
  end

  def part_two
    # Your logic here
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
