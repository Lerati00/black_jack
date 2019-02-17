require_relative "card.rb"

class Deck
  attr_reader :cards

  RANKS = %w[A 2 3 4 5 6 7 8 9 10 J Q K]
  SUITS = ["\u2664", "\u2665", "\u2666", "\u2667" ]
  
  def initialize
    @cards ||= []
    create_new_card_deck
  end

  def create_new_card_deck
    SUITS.each do |suit| 
      RANKS.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
  end

  def mix_deck
    deck = cards
    mix_deck = []
    card = 52
    loop do
      break if card <= 0
      mix_deck << deck.delete_at(rand(card))
      card -= 1
    end
    @cards = mix_deck
  end

  def top_card
    card_deck.pop
  end

  def to_s
    drawing_cards = []
    cards.each { |card| drawing_cards << card.to_s }
    drawing_cards
  end
end



  


