require "./lib/deck"
require "./lib/player"
require "./lib/card"

class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1       = player1
    @player2       = player2
    @spoils_of_war = []
    @type          = :basic
    @turn_winner   = ""
  end

  def type
    if player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
      @type = :basic
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
      if player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
        @type = :mutually_assured_destruction
      else
        @type = :war
      end
    end
  end

  def basic_comparison
    if player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
      @player1
    else
      @player2
    end
  end

  def war_comparison
    if player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2)
      @player1
    else
      @player2
    end
  end

  def winner
    case type
    when :basic
      @turn_winner = basic_comparison
    when :war
      @turn_winner = war_comparison
    when :mutually_assured_destruction
      @turn_winner = "No Winner"
    end
    @turn_winner
  end

  def lose_cards
    @spoils_of_war << player1.deck.remove_card
    @spoils_of_war << player2.deck.remove_card
  end

  def pile_cards
    case type
    when :basic
      lose_cards
    when :war
      3.times do
        lose_cards
      end
    when :mutually_assured_destruction
      3.times do
        player1.deck.remove_card
        player2.deck.remove_card
      end
    end
  end
end
