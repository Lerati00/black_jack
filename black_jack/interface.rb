class Interface
  SET_USER_NAME = 'Введите имя пользователя'
  PULL_THE_CARD = <<~CHOISE
      ------------------    --------------
    //1 - Тянуть карту // //2 - Открыть  //
  CHOISE
  WIN_BANK = " выиграл банк"
  CONTINUE = "\nЖелаете продолжыть"
  DRAW = "Ничья"
  EXIT = " нажмите [ENTER] |Для выхода введите - 0"
  START_OVER = "\nЖелаете начать сначала"
  YOU_WIN = "Вы выиграли"
  YOU_LOSE = "Вы проиграли"
  PLAYER = "Player"
  DEALER = "Dealer"

  def create_name
    puts SET_USER_NAME
    (name = gets.chomp).empty? ? PLAYER : name.capitalize
  end

  def game_interface(user, dealer, bank)
    dealer_print = dealer.close? ? print_player_bank(dealer) : dealer.to_s

    puts [dealer_print, print_hand(dealer), print_bank(bank),
          print_hand(user), print_player(user)]
  end

  def result_party(player)
    puts player.nil? ? DRAW : player.name + WIN_BANK
  end

  def pull_the_card?
    puts PULL_THE_CARD
    choice = [1, 2] & [gets.to_i] while choice.nil? || choice.empty?
    [1] == choice ? true : false 
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

  def print_bank(bank)
    "\n\t" + bank.to_s
  end

  def print_player_bank(player)
    "#{player.name}: #{player.bank}"
  end

  def print_player(player)
    "\n" + player.to_s + "\n\n"
  end

  def print_hand(player)
    player.hand.to_s
  end
end
