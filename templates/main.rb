#!/usr/bin/env ruby

require 'optparse'

class Main
  def initialize(data)
    @data = data
  end

  def part_one
    # Your logic here
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
