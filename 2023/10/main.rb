#!/usr/bin/env ruby

require 'optparse'


class Main
  PIPES = %w(| - L J 7 F)
  DEBUG = false

  def puts(str)
    puts str if DEBUG
  end

  def initialize(data)
    @data = data
  end

  def part_one
    @map = @data.map{|l| l.split('') }

    @start = find_start
    furthest_pipe([@start], 0)
  end

  def part_two
    # Your logic here
  end

  private

  def find_start
    y = @map.index{|l| l.include? 'S' }
    x = @map[y].index('S')
    [x, y]
  end

  def furthest_pipe(tiles, steps)
    puts "Map"
    @map.each do |line|
      puts line.join
    end
    puts "Starting tiles: #{tiles.inspect}"
    puts "Steps: #{steps}"
    connected = tiles.reduce([]) do |acc, tile|
      conn = connected_pipes(tile).each do |c|
        acc << c
      end
      mark_tile(tile)
      acc.uniq
    end
    
    puts "Con: #{connected.inspect}"

    if connected.empty?
      puts "No more connected pipes"
      steps
    else
      puts "Call to f with #{connected.inspect} and steps #{steps + 1}"
      furthest_pipe(connected, steps + 1)
    end
  end

  def connected_pipes(tile)
    adj = adjacent_tiles(tile)
      .reject{|t| t == @start }
      .reject{|t| @map[t.last].nil? }
      .reject{|t| @map[t.last][t.first].nil? }
      .reject{|t| @map[t.last][t.first] == '*' }
    puts "Tile: #{tile.inspect}"
    puts "Adj: #{adj.inspect}"
    connected = adj.select{|a| connected_pipe?(tile, a) }
    puts "Conn: #{connected.inspect}"
    connected
  end

  def connected_pipe?(tile, adj)
    pipe = @map[tile.last][tile.first]
    pipe_adj = @map[adj.last][adj.first]
    puts "Tile: #{pipe} #{tile.inspect}"
    puts "Adj: #{pipe_adj} #{adj.inspect}"

    shifts = case pipe
    when '|'
      [
        [0, -1],
        [0, 1]
      ]
    when '-'
      [
        [-1, 0],
        [1, 0]
      ]
    when 'L'
      puts "It's a L"
      [
        [0, -1],
        [1, 0]
      ]
    when 'J'
      [
        [0, -1],
        [-1, 0]
      ]
    when '7'
      [
        [0, 1],
        [-1, 0]
      ]
    when 'F'
      [
        [0, 1],
        [1, 0]
      ]
    when 'S'
      return connected_pipe?(adj, tile)
    else
      return false
    end

    s = shifts.map{|s| [tile.first + s.first, tile.last + s.last] }
    puts "Shifts: #{s.inspect}"
    res = s.include? adj
    puts "Is adj?: #{res}"
    res
  end

  def adjacent_tiles(tile)
    x_range = (tile.first - 1)..(tile.first + 1)
    y_range = (tile.last - 1)..(tile.last + 1)

    adj = []
    x_range.to_a.each do |x|
      y_range.to_a.each do |y|
        adj << [x, y] unless [x, y] == tile
      end
    end
    adj
  end

  def mark_tile(tile)
    @map[tile.last][tile.first] = '*'
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
