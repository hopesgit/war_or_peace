require "./lib/deck"
require "./lib/player"
require "./lib/card"

class Turn
  attr_reader :player1, :player2, :spoils_of_war, :turn_type

  def initialize(player1, player2)
    @player1       = player1
    @player2       = player2
    @spoils_of_war = []
    @turn_type     = :basic
    @turn_winner   = ""
  end

  def type
    if player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
      @turn_type = :basic
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
      if player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
        @turn_type = :mutually_assured_destruction
      else
        @turn_type = :war
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
    case @turn_type
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
    case @turn_type
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

  def award_spoils
    @spoils_of_war.shuffle!
    case @turn_winner
    when player1
      @player1.deck.add_card(spoils_of_war)
    when player2
      @player2.deck.add_card(spoils_of_war)
    end
    @spoils_of_war.clear
  end
end
