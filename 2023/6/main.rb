#!/usr/bin/env ruby

require 'optparse'

class Main
  def initialize(data)
    @data = data
  end

  def part_one
    times, distances = @data.map do |line|
      line.split(':').last.strip.split(' ').map(&:to_i)
    end

    times.map.with_index do |time, index|
      distance = distances[index]
      (0..time).map do |t|
        d = (time - t) * t
      end.select do |d|
        d > distance
      end.count
    end.reduce(:*)
  end

  def part_two
    time, distance = @data.map do |line|
      line.split(':').last.strip.split(' ').join.to_i
    end

    (0..time).map do |t|
      d = (time - t) * t
    end.select do |d|
      d > distance
    end.count
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
