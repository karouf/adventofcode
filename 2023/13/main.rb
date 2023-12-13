#!/usr/bin/env ruby

require 'optparse'

class Main
  def initialize(data)
    @data = data
  end

  def part_one
    patterns = @data.chunk { |chunk| chunk != '' || nil }.map(&:last)
    transposed_patterns = patterns.map do |pattern|
      pattern.map do |line|
        line.split('')
      end.transpose
    end

    potential_horizontal = patterns.map do |pattern|
      pattern.each_cons(2).with_index.select do |(a, b), i|
        a == b
      end.map(&:last)
    end
    potential_vertical = transposed_patterns.map do |pattern|
      pattern.each_cons(2).with_index.select do |(a, b), i|
        a == b
      end.map(&:last)
    end

    real_horizontal = potential_horizontal.map.with_index do |pattern, index|
      pattern.select do |i|
        truly_mirrored(i, index, patterns)
      end
    end
    real_vertical = potential_vertical.map.with_index do |pattern, index|
      pattern.select do |i|
        truly_mirrored(i, index, transposed_patterns)
      end
    end

    real_horizontal.map! { |pattern| pattern.map { |i| i + 1 } }
    real_vertical.map! { |pattern| pattern.map { |i| i + 1 } }

    real_vertical.flatten.sum + real_horizontal.flatten.sum * 100
  end

  def part_two
    # Your logic here
  end

  private

  def truly_mirrored(axis, index, patterns)
    max_i = patterns[index].length - 1
    (0..axis).to_a.reverse.each do |j|
      mirror_j = axis + 1 + (axis - j)
      if patterns[index][j] != patterns[index][mirror_j]
        return false
      else
        if j == 0 || mirror_j == max_i
          return true
        end
      end
    end
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
