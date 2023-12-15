#!/usr/bin/env ruby

require 'optparse'

class Main
  def initialize(data)
    @data = data
  end

  def part_one
    steps = @data.first.split(',')
    steps.map do |step|
      hash(step)
    end.sum
  end

  def part_two
    steps = @data.first.split(',').map do |step|
      label, operation, focal = step.match(/(?<label>[a-z]+)(?<operation>-|=)(?<focal>\d+)?/).captures
      { label:, operation:, focal: focal.to_i }
    end
    boxes = set_boxes(steps)
    boxes.map.with_index do |box, index|
      if box.empty?
        0
      else
        box.map do |key, value|
          (index + 1) * (box.keys.index(key) + 1) * value
        end.sum
      end
    end.sum

  end

  private

  def hash(step)
    step.each_byte.reduce(0) do |acc, char|
      acc += char
      acc *= 17
      acc % 256
    end
  end

  def set_boxes(steps)
    boxes = []

    256.times do
      boxes << {}
    end

    steps.each do |step|
      box = boxes[hash(step[:label])]

      case step[:operation]
      when '-'
        box.delete(step[:label])
      when '='
        box[step[:label]] = step[:focal]
      end
    end
    boxes
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
