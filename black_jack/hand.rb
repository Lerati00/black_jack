class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def take_card(card)
    raise unless card.is_a?(Card)
    @cards << card
    card
  end

  def score
    cards.sum(&:point) || 0
  end
  
  def to_s
    drawing_hand = ["", "", ""]
    cards.each do |card|
      3.times do |index|
        drawing_hand[index] = drawing_hand[index].chomp + card.to_s.lines[index]
      end
    end
    drawing_hand
  end
end