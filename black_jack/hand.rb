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
    ace_correction(sum)
  end

  def ace_correction(point)
    cards.each do |card|
      if point > MAX_POINT && card.ace?
        point -= Card::ACE_CORRECT
        break if point <= MAX_POINT
      end
    end
    point
  end

  def close
    cards.each(&:close)
  end

  def open
    cards.each(&:open)
  end

  def to_s
    drawing_hand = ['', '', '']
    cards.each do |card|
      3.times do |index|
        drawing_hand[index] = drawing_hand[index].chomp + card.to_s.lines[index]
      end
    end
    drawing_hand
  end
end
