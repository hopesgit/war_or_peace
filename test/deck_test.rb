require 'minitest/autorun'
require 'minitest/pride'
require "./lib/deck"

class DeckTest < Minitest::Test

  def test_it_is_a_deck_of_cards
    deck = Deck.new

    assert_instance_of Deck, deck
  end

  def test_it_can_hold_cards
    card1 = Card.new(:diamond, "Queen", 12)
    card2 = Card.new(:spade, "3", 3)
    card3 = Card.new(:heart, "Ace", 14)
    cards_to_add = [card1, card2, card3]
    deck = Deck.new(cards_to_add)

    assert_equal [card1, card2, card3], deck.cards
  end

  def test_it_can_start_with_or_without_cards
    deck1 = Deck.new
    card1 = Card.new(:diamond, "Queen", 12)
    card2 = Card.new(:spade, "3", 3)
    card3 = Card.new(:heart, "Ace", 14)
    cards_to_add = [card1, card2, card3]
    deck2 = Deck.new(cards_to_add)

    assert_equal [], deck1.cards
    assert_equal [card1, card2, card3], deck2.cards
  end

  def test_it_can_find_rank
    card1 = Card.new(:diamond, "Queen", 12)
    card2 = Card.new(:spade, "3", 3)
    card3 = Card.new(:heart, "Ace", 14)
    cards = [card1, card2, card3]
    deck = Deck.new(cards)

    assert_equal 12, deck.rank_of_card_at(0)
    assert_equal 14, deck.rank_of_card_at(2)
  end

  def test_it_can_find_high_cards
    card1 = Card.new(:diamond, "Queen", 12)
    card2 = Card.new(:spade, "3", 3)
    card3 = Card.new(:heart, "Ace", 14)
    cards = [card1, card2, card3]
    deck = Deck.new(cards)

    assert_equal [card1, card3], deck.high_ranking_cards
  end

  def test_it_can_get_percent_high_cards
    card1 = Card.new(:diamond, "Queen", 12)
    card2 = Card.new(:spade, "3", 3)
    card3 = Card.new(:heart, "Ace", 14)
    cards = [card1, card2, card3]
    deck = Deck.new(cards)

    assert_equal 66.67, deck.percent_high_ranking
  end

  def test_adding_and_removing_cards_changes_high_card_calculations
    card1 = Card.new(:diamond, "Queen", 12)
    card2 = Card.new(:spade, "3", 3)
    card3 = Card.new(:heart, "Ace", 14)
    card4 = Card.new(:club, "5", 5)
    cards = [card1, card2, card3]
    deck = Deck.new(cards)

    assert_equal [card1, card2, card3], deck.cards

    deck.remove_card

    assert_equal [card2, card3], deck.cards
    assert_equal [card3], deck.high_ranking_cards
    assert_equal 50.0, deck.percent_high_ranking

    deck.add_card(card4)

    assert_equal [card2, card3, card4], deck.cards
    assert_equal [card3], deck.high_ranking_cards
    assert_equal 33.33, deck.percent_high_ranking
  end

  def test_it_can_create_cards
    deck = Deck.new
    deck.generate_cards

    assert_equal 52, deck.cards.count
    assert_equal 52, deck.cards.uniq.count
  end
end
