class Card
  attr_reader :rank, 
              :suit, 
              :point

  attr_accessor :type

  ACE_CORRECT = 10
  CLOSED_CARD = <<~CLOSED
     __ 
    | /|
    |/ |
  CLOSED

  def initialize(rank, suit)
    @rank  = rank
    @suit  = suit
    @point = initialize_point
    @type  = :open
  end

  def initialize_point
    rank_ = [rank]
    raise if (rank_ & %w[2 3 4 5 6 7 8 9 10 J Q K A]).empty?

    return rank.to_i if (rank_ & %w[2 3 4 5 6 7 8 9 10]).any?
    return 10        if (rank_ & %w[J Q K]).any?
    return 11        if (rank_ & %w[A]).any?
  end

  def ace?
    @point == 11
  end

  def close
    @type = :close
    self
  end

  def open
    @type = :open
    self
  end

  def to_s
    if type == :open
      rank_ = rank[1].nil? ? rank + " " : rank
      drawing_card = <<~DRAWING
         __ 
        |#{rank_}|
        |_#{suit}|
      DRAWING
    elsif type == :close
      CLOSED_CARD
    end
  end

end