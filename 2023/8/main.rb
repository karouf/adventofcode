#!/usr/bin/env ruby

require 'optparse'

class Main
  def initialize(data)
    @data = data
  end

  def part_one
    instructions, nodes = parse_data(@data)

    steps = 0
    node = 'AAA'
    instructions.cycle do |instruction|
      side = instruction == 'L' ? 0 : 1
      node = nodes[node][side]
      steps += 1
      break if node == 'ZZZ'
    end

    steps
  end

  def part_two
    instructions, nodes = parse_data(@data)
    starts = nodes.keys.select { |k| k.end_with?('A') }
    stops = nodes.keys.select { |k| k.end_with?('Z') }

    starts.map! do |start|
      steps = 0
      node = start
      first_stop_found = false
      first_stop_steps = 0

      instructions.cycle do |instruction|
        side = instruction == 'L' ? 0 : 1
        node = nodes[node][side]
        steps += 1

        if node.end_with? 'Z'
          break if first_stop_found
          first_stop_found = true
          first_stop_steps = steps
        end
      end
      {start:, stop: node, first_stop_steps:, next_stop_steps: steps - first_stop_steps}
    end

    starts.map { |start| start[:first_stop_steps] }.reduce(&:lcm)
  end

  private

  def parse_data(data)
    instructions = data[0].split('')
    nodes = {}
    data[2..-1].each do |line|
      node, sides = line.split(' = ')
      nodes[node] = sides[1..-2].split(', ')
    end
    [instructions, nodes]
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
