#!/usr/bin/env ruby

require 'optparse'

class String
  def ^( other )
    b1 = self.unpack("U*")
    b2 = other.unpack("U*")
    longest = [b1.length,b2.length].max
    b1 = [0]*(longest-b1.length) + b1
    b2 = [0]*(longest-b2.length) + b2
    b1.zip(b2).map{ |a,b| a^b }.pack("U*")
  end
end

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
    patterns = @data.chunk { |chunk| chunk != '' || nil }.map(&:last).map do |pattern|
      pattern.map do |line|
        line.split('')
      end
    end
    transposed_patterns = patterns.map do |pattern|
      pattern.transpose
    end

    potential_horizontal = patterns.map do |pattern|
      pattern.each_cons(2).with_index.select do |(a, b), i|
        a == b || only_one_difference(a, b)
      end.map(&:last)
    end
    potential_vertical = transposed_patterns.map do |pattern|
      pattern.each_cons(2).with_index.select do |(a, b), i|
        a == b || only_one_difference(a, b)
      end.map(&:last)
    end

    real_horizontal = potential_horizontal.map.with_index do |pattern, index|
      pattern.select do |i|
        truly_mirrored_with_smudge(i, index, patterns)
      end
    end
    real_vertical = potential_vertical.map.with_index do |pattern, index|
      pattern.select do |i|
        truly_mirrored_with_smudge(i, index, transposed_patterns)
      end
    end

    real_horizontal.map! { |pattern| pattern.map { |i| i + 1 } }
    real_vertical.map! { |pattern| pattern.map { |i| i + 1 } }

    real_vertical.flatten.sum + real_horizontal.flatten.sum * 100
  end

  private

  def only_one_difference(a, b)
    a.zip(b).select { |a, b| a != b }.length == 1
  end

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

  def truly_mirrored_with_smudge(axis, index, patterns)
    smudge_fixed = false
    max_i = patterns[index].length - 1
    (0..axis).to_a.reverse.each do |j|
      mirror_j = axis + 1 + (axis - j)
      if patterns[index][j] != patterns[index][mirror_j]
        if only_one_difference(patterns[index][j], patterns[index][mirror_j]) && !smudge_fixed
          smudge_fixed = true
          if j == 0 || mirror_j == max_i
            return smudge_fixed
          else
            next
          end
        else
          return false
        end
      else
        if j == 0 || mirror_j == max_i
          return smudge_fixed
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
