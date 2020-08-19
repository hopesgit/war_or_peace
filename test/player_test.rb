require 'minitest/autorun'
require 'minitest/pride'
require "./lib/player"

class PlayerTest < Minitest::Test
  def test_it_is_a_player
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    deck = Deck.new([card1, card2, card3])
    player = Player.new('Clarisa', deck)

    assert_instance_of Player, player
  end

  def test_it_has_attributes
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    deck = Deck.new([card1, card2, card3])
    player = Player.new('Clarisa', deck)

    assert_equal "Clarisa", player.name
    assert_equal deck, player.deck
  end

  def test_it_can_tell_if_player_lost
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    deck = Deck.new([card1, card2, card3])
    player = Player.new('Clarisa', deck)

    refute player.has_lost?
    player.deck.remove_card
    refute player.has_lost?
    player.deck.remove_card
    refute player.has_lost?
    player.deck.remove_card
    assert player.has_lost?

    assert_equal [], player.deck.cards
  end
end
