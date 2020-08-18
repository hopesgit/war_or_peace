require 'minitest/autorun'
require 'minitest/pride'
require "./lib/deck"

class DeckTest < Minitest::Test

  def test_it_is_a_deck_of_cards
    deck1 = Deck.new

    assert_instance_of Deck, deck1
  end
end
