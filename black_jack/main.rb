require_relative "card.rb"
require_relative "hand.rb"
require_relative "deck.rb"
require_relative "player.rb"
require_relative "user.rb"
require_relative "dealer.rb"
require_relative "bank.rb"
require_relative "interface.rb"

class Main
  def initialize
    @interface = Interface.new
    @bank   = Bank.new
    @dealer = Dealer.new("Dealer")
    @deck   = Deck.new
    @user   = User.new(@interface.create_name)  
  end

  def run
    loop do
      start_party
      user_game
      dealer_game
      end_party
      
      if user.lose? || dealer.lose? 
        @interface.start_over? ? reset_bank : break 
      else 
        break unless @interface.continue?
      end
    end
  end

  protected

  attr_reader :bank,
              :user, 
              :dealer,
              :deck

  def reset_bank
    user.reset_bank
    dealer.reset_bank
  end

  def start_party
    deck.mix_deck

    starting_hand(user)
    starting_hand(dealer)
    dealer.close_card

    bank.withdraw_bet(user, dealer)
  end

  def starting_hand(player) 
    player.give_card(deck.top_card)
    player.give_card(deck.top_card)  
  end

  def pull_the_card
    user.give_card(deck.top_card)  if @interface.pull_the_card?
  end

  def user_game
    loop do
      @interface.game_interface(user, dealer, bank)
      break if pull_the_card.nil? || user.overload?
    end
  end

  def dealer_game
    dealer.open_card 
    dealer.give_card(deck.top_card) while dealer.to_little?
  end

  def end_party
    (player = winner).nil? ? bank.draw(user, dealer) : bank.return_winings(player)

    @interface.game_interface(user, dealer, bank)
    @interface.result_party(player)

    reset_party
  end

  def reset_party
    deck.create_new_deck
    user.reset_hand
    dealer.reset_hand
  end

  def winner
    return if (dealer.overload? && user.overload?) || user.score == dealer.score
    return dealer  if user.overload? || (user.score < dealer.score && !dealer.overload?)
    return user    
  end

end

Main.new.run
