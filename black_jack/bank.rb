class Bank
  attr_reader :amount

  BET = 10

  def initialize
    @amount = 0
  end

  def reset
    @amount = 0
  end

  def withdraw_bet(user, dealer)
    user.bet(BET)
    dealer.bet(BET)
    @amount += BET * 2
  end

  def return_winings(player)
    player.win_bet(amount)
    reset
  end

  def draw(user, dealer)
    bet = amount / 2
    user.win_bet(bet)
    dealer.win_bet(bet)
    reset
  end

  def to_s
    "Bank: #{amount}"
  end
end