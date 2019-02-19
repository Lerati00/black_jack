class Hand
  attr_reader :cards 

  MAX_POINT = 21

  def initialize
    @cards = []
  end

  def take_card(card)
    @cards << card
    card
  end

  def score
    sum = cards.sum(&:point) || 0
    @cards.each do |card|
      if sum > MAX_POINT && card.ace?
        sum -= Card::ACE_CORRECT
        break if sum <= MAX_POINT
      end
    end
    sum
  end

  def close
    cards.each { |card| card.close}
  end

  def open
    cards.each { |card| card.open}
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