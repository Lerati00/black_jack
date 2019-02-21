require_relative 'card.rb'

class Deck
  attr_reader :cards

  def initialize
    create_new_deck
  end

  def create_new_deck
    @cards = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
  end

  def mix_deck
    cards.shuffle!
  end

  def top_card
    cards.pop
  end

  def to_s
    drawing_cards = []
    cards.each { |card| drawing_cards << card.to_s }
    drawing_cards
  end
end
