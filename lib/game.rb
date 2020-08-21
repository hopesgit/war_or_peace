require "./lib/card"
require "./lib/deck"
require "./lib/player"
require "./lib/turn"

class Game
  attr_reader :turn

  def initialize(turn)
    @turn       = turn
    @turn_count = 0
    @winner     = ""
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
    deck_of_cards = Deck.new
    deck_of_cards.generate_cards
    p1deck = deck_of_cards.cards[0..25]
    p2deck = deck_of_cards.cards[26..51]
    @turn.player1.deck.add_card(p1deck)
    @turn.player2.deck.add_card(p2deck)
  end
end
