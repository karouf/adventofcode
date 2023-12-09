#!/usr/bin/env ruby

require 'optparse'

class Main
  def initialize(data)
    @data = data
  end

  def part_one
    data = @data.map(&:split).map{|i| i.map(&:to_i) }

    data.map do |seq|
      seqs = [seq]
      start = seq
      loop do
        d = diffs(start)
        seqs << d
        break if d.all?(0)
        start = d
      end

      seqs.reverse!

      seqs.each_with_index do |s, i|
        break if i == seqs.length - 1
        seqs[i+1] << (seqs[i+1].last + s.last)
      end
      seqs.last.last
    end.sum
  end

  def part_two
    data = @data.map(&:split).map{|i| i.map(&:to_i) }

    data.map do |seq|
      seqs = [seq]
      start = seq
      loop do
        d = diffs(start)
        seqs << d
        break if d.all?(0)
        start = d
      end

      seqs.reverse!

      seqs.each_with_index do |s, i|
        break if i == seqs.length - 1
        seqs[i+1].unshift(seqs[i+1].first - s.first)
      end
      seqs.last.first
    end.sum
  end

  private

  def diffs(seq)
    seq.each.with_index.reduce([]) do |diffs, (item, index)|
      next_item = seq[index+1]
      diffs << (next_item - item) unless next_item.nil?
      diffs
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
