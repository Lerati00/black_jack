require_relative 'card.rb'
require_relative 'hand.rb'
require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'user.rb'
require_relative 'dealer.rb'
require_relative 'bank.rb'
require_relative 'interface.rb'

class Main
  def initialize
    @interface = Interface.new
    @bank   = Bank.new
    @dealer = Dealer.new(Interface::DEALER)
    @deck   = Deck.new
    @user   = User.new(@interface.create_name)
  end

  def run
    loop do
      start_party
      loop do
        user_game
        dealer_game
        break if end_turn?
      end
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
              :deck,
              :end_turn,
              :skip

  def end_turn?
    end_turn ? end_turn : user.maximum_cards? 
  end

  def reset_bank
    user.reset_bank
    dealer.reset_bank
  end

  def start_party
    @end_turn = false
    @skip = false
    deck.create_new_deck
    deck.mix_deck

    starting_hand(user)
    starting_hand(dealer)
    user.open_card

    bank.withdraw_bet(user, dealer)
  end

  def starting_hand(player)
    player.give_card(deck.top_card)
    player.give_card(deck.top_card)
  end

  def pull_the_card
    choice = @interface.pull_the_card
    user.give_card(deck.top_card.open) if choice == :pull_card
    @end_turn = choice == :pull_card || choice == :open
  end

  def user_game
    @interface.game_interface(user, dealer, bank)
    pull_the_card
  end

  def dealer_game
    dealer.give_card(deck.top_card) while dealer.to_little? && !dealer.maximum_cards?
    dealer.open_card if end_turn?
  end

  def end_party
    (player = winner).nil? ? bank.draw(user, dealer) : bank.return_winings(player)

    @interface.game_interface(user, dealer, bank)
    @interface.result_party(player)

    reset_party
  end

  def reset_party
    user.reset_hand
    dealer.reset_hand
  end

  def winner
    return if dealer.overload? && user.overload?
    return if user.score == dealer.score
    return user if dealer.overload?
    return dealer if user.overload?
    [user, dealer].max_by(&:score)
  end
end

Main.new.run
