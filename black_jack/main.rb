require_relative "card.rb"
require_relative "hand.rb"
require_relative "deck.rb"
require_relative "player.rb"
require_relative "user.rb"
require_relative "dealer.rb"
require_relative "bank.rb"
require_relative "interface_constants.rb"

class Main
  include InterfaceConstants

  def initialize
    @bank   = Bank.new
    @dealer = Dealer.new("Dealer")
    @deck   = Deck.new
    initialize_user
  end

  def run
    loop do
      start_party
      user_game
      dealer_game
      end_party
      
      if user.lose? || dealer.lose? 
        start_over? ? reset_bank : break 
      else 
        break unless continue?
      end
    end
  end

  protected

  attr_reader :bank,
              :user, 
              :dealer,
              :deck

  def initialize_user
    puts SET_USER_NAME
    @user = User.new(gets.chomp)
  end

  def reset_bank
    user.reset_bank
    dealer.reset_bank
  end

  def start_party
    deck.mix_deck

    user.give_card(deck.top_card)
    user.give_card(deck.top_card)

    dealer.give_card(deck.top_card)
    dealer.give_card(deck.top_card)
    dealer.close_card

    bank.withdraw_bet(user, dealer)
  end

  def game_interface
    dealer_print = dealer.close? ? dealer_bank : dealer.to_s
    [dealer_print, print_hand(dealer), print_bank, print_hand(user), print_user]
  end

  def pull_the_card
    puts PULL_THE_CARD
    choice = [1, 2] & [gets.to_i] while choice.nil? || choice.empty? 
    user.give_card(deck.top_card)  if [1] == choice 
  end

  def user_game
    loop do
      puts game_interface
      break if pull_the_card.nil? || user.overload?
    end
  end

  def dealer_game
    dealer.open_card 
    dealer.give_card(deck.top_card) while dealer.to_little?
  end

  def end_party
    message = if (player = winner(user, dealer)).nil? 
                bank.draw(user, dealer) 
                DRAW
              else
                bank.return_winings(player)
                player.name + WIN_BANK
              end  

    puts game_interface
    puts message

    deck.create_new_deck
    user.reset_hand
    dealer.reset_hand
  end

  def continue?
    puts CONTINUE + EXIT 
    gets.chomp == '0' ? false : true
  end

  def start_over?
    puts YOU_LOSE if user.lose?
    puts YOU_WIN if dealer.lose?
    puts START_OVER + EXIT
    gets.chomp == '0' ? false : true
  end

  def winner(user, dealer)
    return if !user.overload? && user.score == dealer.score
    return dealer  if user.overload?
    return user    if !user.overload? && dealer.overload? || user.score > dealer.score
    return dealer  if user.score < dealer.score
  end

  def dealer_bank
    "#{dealer.name}: #{dealer.bank}"
  end

  def dealer_score
    "Score: #{dealer.score}"
  end

  def closed_card
    CLOSED_CARD
  end

  def print_bank
    "\n\t" + bank.to_s
  end

  def print_hand(player)
    player.hand.to_s
  end

  def print_user
    "\n" + user.to_s + "\n\n"
  end

end

Main.new.run
