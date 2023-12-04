#!/usr/bin/env ruby

require 'optparse'

class Main

  def initialize(data)
    @data = data
    @won_cards_cache = {}
  end

  def part_one
    @data.map do |card|
      my_winners = my_winners(card)
      my_winners.empty? ? 0 : 2**(my_winners.size - 1)
    end.sum
  end

  def part_two
    total_cards = 0
    @data.each do |card|
      total_cards += process_card(card)
    end
    total_cards
  end

  private

  def my_winners(card)
    winners, mine = card.split(':')
      .last
      .split('|')
      .map(&:strip)
      .map { |c| c.split(' ').map(&:to_i) }
    mine.select { |m| winners.include?(m) }
  end

  def process_card(card)
    return @won_cards_cache[card] if @won_cards_cache[card]

    copies = won_cards(card)
    total_cards = 1
    copies.each do |copy|
      total_cards += process_card(copy)
    end

    @won_cards_cache[card] = total_cards

    total_cards
  end

  def won_cards(card)
    card_index = @data.index(card)
    @data[card_index+1, my_winners(card).count]
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
