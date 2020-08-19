require 'minitest/autorun'
require 'minitest/pride'
require "./lib/deck"

class DeckTest < Minitest::Test

  def test_it_is_a_deck_of_cards
    deck1 = Deck.new

    assert_instance_of Deck, deck1
  end

  def test_it_can_hold_cards
    deck1 = Deck.new
    heartjack = Card.new(:heart, "Jack", 11)
    heartqueen = Card.new(:heart, "Queen", 12)
    heartking = Card.new(:heart, "King", 13)
    cards = [heartqueen, heartking]

    assert_equal [], deck1.cards

    deck1.add_card(heartjack)
    assert_equal [heartjack], deck1.cards

    deck1.add_card(cards)
    assert_equal [heartjack, heartqueen, heartking], deck1.cards
  end
end
