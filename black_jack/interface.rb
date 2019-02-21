class Interface
  SET_USER_NAME = 'Введите имя пользователя'
  PULL_THE_CARD = <<~CHOISE
      ------------------ ----------------- ---------------
    //1 - Тянуть карту // 2 - Пропустить // 3 - Открыть  //
  CHOISE
  SKIP = <<~SKIP
     
   
  SKIP
  OPEN = <<~OPEN
     
    
  OPEN
  WIN_BANK = " выиграл банк"
  CONTINUE = "\nЖелаете продолжить"
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

  def pull_the_card
    puts PULL_THE_CARD
    choice = gets.to_i until choice&.between?(1, 3)
    [:pull_card, :skip, :open][choice -1]
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
