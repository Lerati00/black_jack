class Dealer < Player
  DEALLER_RULE = 17

  def to_little?
    score < DEALLER_RULE
  end
end
