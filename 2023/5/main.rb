#!/usr/bin/env ruby

require 'optparse'

class Main
  def initialize(data)
    @data = data
    @maps = []
  end

  def part_one
    maps.each do |map|
      if map.first =~ /^seeds:/
        @seeds = parse_seeds(map)
      else
        @maps << mapping(map)
      end
    end

    @seeds.map do |seed|
      @maps.reduce(seed) do |mem, map|
        find_value(map, mem)
      end
    end.min
  end

  def part_two
    maps.each do |map|
      if map.first =~ /^seeds:/
        @seeds = parse_seed_ranges(map)
      else
        @maps << mapping(map)
      end
    end

    require 'parallel'
    @seeds.map do |seed_range|
      Parallel.map(seed_range, progress: 'Going through seed ranges') do |seed|
        @maps.reduce(seed) do |mem, map|
          find_value(map, mem)
        end
      end
    end.flatten.min

    #@maps.reverse.map.with_index do |map, index|
    #  ranges = map_ranges(map).sort_by(&:min)
    #  ranges.select do |range|
    #    map_ranges(@maps.reverse[index + 1]).any? do |next_range|
    #      range.min <= next_range.max && range.max >= next_range.min
    #    end
    #  end
  end

  private

  def parse_seeds(map)
    map.first.split(':').last.strip.split(' ').map(&:to_i)
  end

  def parse_seed_ranges(map)
    map.first.split(':').last.strip.split(' ').map(&:to_i).each_slice(2).to_a.map { |p| p[0]..(p[0] + p[1]) }
  end

  def maps
    @data.slice_when { |a, b| a == '' || b == '' }.reject { |i| i == [''] }.to_a
  end

  def mapping(map)
    map.reject { |l| l =~ /\w+-to-\w+ map:/ }
       .map { |line| line.split(' ').map(&:to_i) }
       .map { |i| [i[1]..(i[1] + i[2] - 1), i[0]] }
       .to_h
  end

  def map_ranges(map)
    map.reject { |l| l =~ /\w+-to-\w+ map:/ }
       .map { |line| line.split(' ').map(&:to_i) }
       .map { |i| i[1]..(i[1] + i[2] - 1) }
  end

  def find_value(ranges, src)
    if range = ranges.keys.find { |range| range.include?(src) }
      ranges[range] + (src - range.first)
    else
      src
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
