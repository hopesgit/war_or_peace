require "./lib/card"

class Deck
  attr_reader :cards

  def initialize(cards=nil)
    @cards = [cards].flatten.compact
  end

  def generate_cards
    suits = [:heart, :diamond, :spade, :club]
    suits.each do |suit|
      generate_cards_in_suit(suit)
    end
  end

  def generate_cards_in_suit(suit)
    ranks = {2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9", 10 => "10", 11 => "Jack", 12 => "Queen", 13 => "King", 14 => "Ace"}
    ranks.each do |rank, value|
      @cards << Card.new(suit, value, rank)
    end
  end

  def add_card(card_to_add)
    @cards << card_to_add
    @cards.flatten!
  end

  def rank_of_card_at(index)
    rank_to_find = @cards[index]
    if rank_to_find.class == Card
      rank_to_find.rank
    else
      1
    end
  end

  def high_ranking_cards
    @cards.find_all do |card|
      card.rank > 10
    end
  end

  def percent_high_ranking
    denominator = @cards.count.to_f
    numerator = high_ranking_cards.count
    (numerator / denominator * 100).round(2)
  end

  def remove_card
    @cards.shift
  end
end
