require "./lib/card"

class Deck
  attr_reader :cards

  def initialize
    @cards = []
  end

  def generate_cards
  end

  def add_card(card_to_add)
    @cards << card_to_add
    @cards.flatten!
  end
end
