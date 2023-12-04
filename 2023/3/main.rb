#!/usr/bin/env ruby

require 'optparse'

class Main
  def initialize(data)
    @data = data
    @adjacent_parts_to_gear = {}
  end

  def part_one
    parts = @data.map.with_index do |line, index|
      extract_numbers(line).map do |n|
        n.merge({ line: index })
      end.reject do |number|
        surrounding(number).all?{|c| c =~ /\d|\./ }
      end.map{|n| n[:number].to_i}
    end.flatten

    parts.sum
  end

  def part_two
    gears = extract_gears
    gears = gears.select{|g| real_gear?(g)}
    gears.map do |g|
      adjacent_parts_to_gear(g).reduce(1){|acc, part| acc *= part[:number].to_i }
    end.sum
  end

  private

  def numbers
    @numbers ||= @data.map.with_index do |line, index|
      extract_numbers(line).map do |n|
        n.merge({ line: index })
      end
    end.flatten
  end

  def extract_gears
    gears = []
    @data.each_with_index do |line, y|
      line.chars.each_with_index do |char, x|
        gears << [x, y] if char == '*'
      end
    end

    gears
  end

  def adjacent_parts_to_gear(gear)
    @adjacent_parts_to_gear[gear] ||= numbers.select do |n|
      n[:line] < gear.last + 2 &&
        n[:line] > gear.last - 2 &&
        !((n[:start]..n[:stop]).to_a & ((gear.first - 1)..(gear.first + 1)).to_a).empty?
    end
  end

  def real_gear?(gear)
    adjacent_parts_to_gear(gear).count == 2
  end

  def extract_numbers(line)
    numbers = []
    in_number = false
    number = ''
    start = nil
    stop = nil

    line.chars.each_with_index do |char, index|
      if char =~ /\d/
        start = index unless in_number
        in_number = true
        number << char
      else
        if in_number
          stop = index - 1 if in_number
          numbers << {number:, start:, stop:}
        end
        in_number = false
        number = ''
      end
    end

    if in_number
      stop = line.length - 1
      numbers << {number:, start:, stop:}
    end

    numbers
  end

  def surrounding(number)
    surrounding = []
    line = @data[number[:line]]
    line_above = @data[number[:line] - 1]
    line_below = @data[number[:line] + 1]
    start = number[:start]
    stop = number[:stop]

    surrounding << line_above[start..stop] unless number[:line].zero?
    surrounding << line_below[start..stop] unless number[:line] == @data.length - 1

    unless start.zero?
      surrounding << line[start - 1]
      surrounding << line_above[start - 1] unless number[:line].zero?
      surrounding << line_below[start - 1] unless number[:line] == @data.length - 1
    end

    unless stop == line.length - 1
      surrounding << line[stop + 1]
      surrounding << line_above[stop + 1] unless number[:line].zero?
      surrounding << line_below[stop + 1] unless number[:line] == @data.length - 1
    end

    surrounding.join.chars
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
