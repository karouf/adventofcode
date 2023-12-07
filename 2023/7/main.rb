#!/usr/bin/env ruby

require 'optparse'

class Main
  HAND_RANKS = %i(
    five_of_a_kind
    four_of_a_kind
    full_house
    three_of_a_kind
    two_pairs
    one_pair
    high_card
  ).freeze

  CARDS_RANKS = %w(A K Q J T 9 8 7 6 5 4 3 2).freeze
  CARDS_RANKS_WITH_JOKER = %w(A K Q T 9 8 7 6 5 4 3 2 J).freeze


  def initialize(data)
    @data = data
  end

  def part_one

    hands = parse_data
    hands.map! do |hand|
      {hand: hand[:hand], bet: hand[:bet], rank: rank(hand)}
    end

    hands.sort_by do |hand|
      [
        HAND_RANKS.index(hand[:rank]),
        CARDS_RANKS.index(hand[:hand][0]),
        CARDS_RANKS.index(hand[:hand][1]),
        CARDS_RANKS.index(hand[:hand][2]),
        CARDS_RANKS.index(hand[:hand][3]),
        CARDS_RANKS.index(hand[:hand][4])
      ]
    end.reverse.each_with_index.reduce(0) { |acc, (hand, index)| acc += hand[:bet] * (index+1)}
  end

  def part_two
    hands = parse_data
    hands.map! do |hand|
      {hand: hand[:hand], bet: hand[:bet], rank: rank_with_joker(hand)}
    end

    last = nil
    hands.sort_by do |hand|
      [
        HAND_RANKS.index(hand[:rank]),
        CARDS_RANKS_WITH_JOKER.index(hand[:hand][0]),
        CARDS_RANKS_WITH_JOKER.index(hand[:hand][1]),
        CARDS_RANKS_WITH_JOKER.index(hand[:hand][2]),
        CARDS_RANKS_WITH_JOKER.index(hand[:hand][3]),
        CARDS_RANKS_WITH_JOKER.index(hand[:hand][4])
      ]
    end.reverse.each_with_index.reduce(0) { |acc, (hand, index)| acc += hand[:bet] * (index+1)}
  end

  private

  def parse_data
    @data.map do |line|
      hand, bet = line.split(' ')
      { hand: hand.split(''), bet: bet.to_i }
    end
  end

  def rank(hand)
    case card_groups(hand[:hand])
    when [5]
      :five_of_a_kind
    when [1, 4]
      :four_of_a_kind
    when [2, 3]
      :full_house
    when [1, 1, 3]
      :three_of_a_kind
    when [1, 2, 2]
      :two_pairs
    when [1, 1, 1, 2]
      :one_pair
    when [1, 1, 1, 1, 1]
      :high_card
    end
  end

  def rank_with_joker(hand)
    case card_groups_with_joker(hand[:hand])
    when [5]
      :five_of_a_kind
    when [1, 4]
      :four_of_a_kind
    when [2, 3]
      :full_house
    when [1, 1, 3]
      :three_of_a_kind
    when [1, 2, 2]
      :two_pairs
    when [1, 1, 1, 2]
      :one_pair
    when [1, 1, 1, 1, 1]
      :high_card
    end
  end

  def card_groups(hand)
    hand.tally.values.sort
  end

  def card_groups_with_joker(hand)
    groups = hand.tally
    jokers = groups.delete('J')

    return [5] if groups.empty?

    highest = groups.max_by { |k, v| [v, CARDS_RANKS_WITH_JOKER.index(k)] }[0]
    groups[highest] += jokers if jokers
    groups.values.sort
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
