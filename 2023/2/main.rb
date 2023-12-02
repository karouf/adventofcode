#!/usr/bin/env ruby

require 'optparse'

class Main
  def initialize(data)
    @data = data
  end

  def part_one
    content = {
      "red" => 12,
      "blue" => 14,
      "green" => 13
    }
    # data shape
    # { 1 => [{blue: 3, red: 4, green: 0}, {...}],
    #   2 => ...
    # }
    games = parse_input
    max_colors = max_colors(games)

    possible = max_colors.select do |game, colors|
      colors["red"] <= content["red"] &&
      colors["blue"] <= content["blue"] &&
      colors["green"] <= content["green"]
    end
    possible.map{|k,_| k.to_i}.sum
  end

  def part_two
    games = parse_input
    max_colors = max_colors(games)
    max_colors.map{|_, c| c["red"] * c["blue"] * c["green"]}.sum
  end

  private

  def parse_input
    @data.map do |line|
      game, sets = line.split(':').map(&:strip)
      game_number = game.split(' ').last
      [game_number, sets.split(';').map(&:strip).map do |set|
        colors = set.split(',').map(&:strip).map do |color|
          number, color_name = color.split(' ')
          [color_name, number.to_i]
        end
        colors.to_h
      end]
    end
  end

  def max_colors(games)
    games.to_h.map do |game, sets|
      max_red = sets.map{|s| s["red"]}.reject(&:nil?).max
      max_blue = sets.map{|s| s["blue"] }.reject(&:nil?).max
      max_green = sets.map{|s| s["green"] }.reject(&:nil?).max
      [game, {"red" => max_red, "blue" => max_blue, "green" => max_green }]
    end.to_h
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
