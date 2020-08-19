require "./lib/deck"
require "./lib/player"
require "./lib/card"

class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1       = player1
    @player2       = player2
    @spoils_of_war = []
    @type = :basic
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
      basic_comparison
    when :war
      war_comparison
    when :mutually_assured_destruction
      "No Winner"
    end
  end

end
