require "./lib/card"
require "./lib/deck"
require "./lib/player"
require "./lib/turn"

class Game
  attr_reader :turn, :turn_count

  def initialize(turn)
    @turn          = turn
    @turn_count    = 0
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
    @starting_deck.cards.shuffle!
    p1deck = @starting_deck.cards[0..25]
    p2deck = @starting_deck.cards[26..51]
    @turn.player1.deck.add_card(p1deck)
    @turn.player2.deck.add_card(p2deck)
  end

  def start
    game_intro
    user_input
    cut_cards
  end

  def go_to_war
    until win_condition
      @turn_count += 1
      @turn.type
      @turn.winner
      @turn.pile_cards
      @turn.award_spoils
      turn_result
    end
  end

  def win_condition
    @turn_count == 1000001 || @turn.turn_type == :end
  end

  def debug_turn_count
    @turn_count += 1000001
  end

  def turn_result
    if @turn_count == 1000001
      p "DRAW - Your battle has resulted in a stalemate. Return to base!"
    elsif @turn.turn_type == :basic
      p "Turn #{turn_count}: #{turn.turn_winner.name} won 2 cards"
    elsif @turn.turn_type == :war
      p "Turn #{turn_count}: WAR - #{turn.turn_winner.name} won 6 cards"
    elsif @turn.turn_type == :mutually_assured_destruction
      p "Turn #{turn_count}: *mutually assured destruction* 6 cards removed from play"
    elsif @turn.turn_type == :end
      p "Game over! #{turn.turn_winner.name}'s Army has taken victory!"
    end
  end
end
