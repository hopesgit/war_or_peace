require 'minitest/autorun'
require 'minitest/pride'
require "./lib/turn"

class TurnTest < Minitest::Test

  def test_it_is_a_turn
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card1, card2, card5, card8])
    deck2 = Deck.new([card3, card4, card6, card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)

    assert_instance_of Turn, turn
  end

  def test_it_has_attributes
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card1, card2, card5, card8])
    deck2 = Deck.new([card3, card4, card6, card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)

    assert_equal player1, turn.player1
    assert_equal player2, turn.player2
    assert_equal "Megan", turn.player1.name
    assert_equal "Aurora", turn.player2.name
    assert_equal [], turn.spoils_of_war
  end

  def test_it_has_a_type
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card1, card2, card5, card8])
    deck2 = Deck.new([card3, card4, card6, card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)

    assert_equal :basic, turn.type

    turn.player2.deck.remove_card

    assert_equal :war, turn.type
  end

  def test_basic_comparison
    card1 = Card.new(:heart, 'Jack', 11)
    card3 = Card.new(:heart, '9', 9)
    deck1 = Deck.new([card1])
    deck2 = Deck.new([card3])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)

    assert_equal :basic, turn.type
    assert_equal turn.player1, turn.basic_comparison
  end

  def test_war_comparison
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '9', 9)
    deck1 = Deck.new([card1, card2, card5])
    deck2 = Deck.new([card4, card6, card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)

    assert_equal :war, turn.type
    assert_equal turn.player2, turn.war_comparison
  end

  def test_it_can_find_winner
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card1, card2, card5, card8])
    deck2 = Deck.new([card3, card4, card6, card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)

    assert_equal :basic, turn.type
    assert_equal player1, turn.winner

    turn.player2.deck.remove_card

    assert_equal :war, turn.type
    assert_equal player1, turn.winner
  end

  def test_it_can_remove_cards_from_players
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card8])
    deck2 = Deck.new([card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)

    assert_equal 1, turn.player1.deck.cards.count
    assert_equal 1, turn.player2.deck.cards.count

    turn.lose_cards

    assert_equal 0, turn.player1.deck.cards.count
    assert_equal 0, turn.player2.deck.cards.count

    assert_equal [card8, card7], turn.spoils_of_war
  end

  def test_it_can_move_cards_from_players_to_spoils
    card1 = Card.new(:heart, 'Jack', 11)
    card3 = Card.new(:heart, '9', 9)
    deck1 = Deck.new([card1])
    deck2 = Deck.new([card3])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    turn.pile_cards

    assert_equal [], turn.player1.deck.cards
    assert_equal [], turn.player2.deck.cards
    assert_equal [card1, card3], turn.spoils_of_war
  end

  def test_it_can_award_spoils
    card1 = Card.new(:heart, 'Jack', 11)
    card3 = Card.new(:heart, '9', 9)
    deck1 = Deck.new([card1])
    deck2 = Deck.new([card3])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)

    assert_equal turn.player1, turn.winner

    turn.pile_cards

    assert_equal [], turn.player1.deck.cards
    assert_equal [], turn.player2.deck.cards
    assert_equal [card1, card3], turn.spoils_of_war

    turn.award_spoils

    assert_equal 2, turn.player1.deck.cards.count
    assert_equal 0, turn.player2.deck.cards.count
    assert turn.spoils_of_war.empty?
  end

  def test_basic_path
    card1 = Card.new(:heart, 'Jack', 11)
    card3 = Card.new(:heart, '9', 9)
    deck1 = Deck.new([card3])
    deck2 = Deck.new([card1])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)

    assert_equal :basic, turn.type
    assert_equal player2, turn.winner

    turn.pile_cards

    assert_equal 0, turn.player1.deck.cards.count
    assert_equal 0, turn.player2.deck.cards.count

    turn.award_spoils

    assert_equal 2, turn.player2.deck.cards.count
    assert_equal 0, turn.player1.deck.cards.count
    assert turn.player1.has_lost?
  end

  def test_war_path
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '9', 9)
    deck1 = Deck.new([card1, card2, card5])
    deck2 = Deck.new([card4, card6, card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)

    assert_equal :war, turn.type
    assert_equal player2, turn.winner

    turn.pile_cards

    assert_equal 0, turn.player1.deck.cards.count
    assert_equal 0, turn.player2.deck.cards.count

    turn.award_spoils

    assert_equal 6, turn.player2.deck.cards.count
    assert_equal 0, turn.player1.deck.cards.count
    assert turn.player1.has_lost?
  end
end
