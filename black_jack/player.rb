class Player
  attr_reader :name, :hand, :bank

  STARTING_BANK = 100

  def initialize(name)
    @name = name
    @bank = STARTING_BANK
    @hand = Hand.new
  end

  def reset_hand
    @hand = Hand.new
  end

  def reset_bank
    @bank = STARTING_BANK
  end

  def give_card(card)
    hand.take_card(card)
  end

  def overload?
    score > Hand::MAX_POINT
  end

  def score
    hand.score
  end

  def lose?
    bank <= 0
  end

  def win_bet(bet)
    @bank += bet
  end

  def bet(bet)
    @bank -= bet
  end

  def close_card
    hand.close
  end

  def close?
    hand.cards[0].type == :close
  end

  def open_card
    hand.open
  end

  def to_s
    "#{name}: #{bank}\tScore: #{score}"
  end
  
end