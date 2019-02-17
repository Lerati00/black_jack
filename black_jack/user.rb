class User
  attr_reader :name, :hand, :bank

  def initialize(name)
    @name = name
    @bank = 100
  end

  def starting_hand(hand)
    @hand = hand
  end

  def give_card(card)
    @hand 
  end
end