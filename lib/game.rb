require "./lib/card"
require "./lib/deck"
require "./lib/player"
require "./lib/turn"

class Game
  attr_reader :turn, :winner, :turn_count

  def initialize(turn)
    @turn          = turn
    @turn_count    = 0
    @winner        = ""
    @starting_deck = Deck.new
  end

  def game_intro
    puts "Welcome to War! This game will be played with 52 cards."
    puts "The players today are Megan and Aurora."
    puts "Type 'GO' to start the game!"
    puts "-" * 30
    0
  end

  def user_input
    input = gets.chomp.upcase
    loop do
      if input == "GO"
        break
      else
        "Please try again."
      end
    end
    input
  end

  def cut_cards
    @starting_deck.generate_cards
    p1deck = @starting_deck.cards[0..25]
    p2deck = @starting_deck.cards[26..51]
    @turn.player1.deck.add_card(p1deck)
    @turn.player2.deck.add_card(p2deck)
  end

  def go_to_war
    until win_condition
      @turn_count += 1
      @turn.type
      @turn.winner
      @turn.pile_cards
      @turn.award_spoils
      turn_results
    end
  end

  def card_count
    if turn.player1.deck.cards.count <= 2 && turn.player2.deck.cards.count <= 2
      @winner = :neither
    elsif turn.player2.deck.cards.count <= 2+
      @winner = :player1
    elsif turn.player1.deck.cards.count <= 2
      @winner = :player2
    end
  end

  def not_enough_cards_for_war
    if turn.turn_type == :end
      card_count
    end
  end

  def turn_results
  end

  def win_condition
    @turn_count == 1000000
    turn.turn_type == :end
  end
end
