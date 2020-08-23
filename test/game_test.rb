require 'minitest/autorun'
require 'minitest/pride'
require "mocha/minitest"
require "./lib/game"

class GameTest < Minitest::Test
  def test_it_is_a_game
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
    war = Game.new(turn)

    assert_instance_of Game, war
  end

  def test_it_has_a_turn
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
    war = Game.new(turn)

    assert_equal turn, war.turn
  end

  def test_game_intro
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card8])
    deck2 = Deck.new([card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    war = Game.new(turn)

    assert_equal 0, war.game_intro
  end

  def test_it_can_accept_user_input_to_start_game
    skip
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card8])
    deck2 = Deck.new([card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    war = Game.new(turn)
    war.game_intro

    assert_equal "GO", war.user_input
  end

  def test_game_can_be_set_up
    deck1 = Deck.new
    deck2 = Deck.new
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    war = Game.new(turn)

    war.cut_cards

    assert_equal 26, war.turn.player1.deck.cards.uniq.count
    assert_equal 26, war.turn.player2.deck.cards.uniq.count
  end

  def test_win_condition_card_route
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card4 = Card.new(:diamond, 'Jack', 11)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    deck1 = Deck.new([card1, card2])
    deck2 = Deck.new([card4, card6, card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    war = Game.new(turn)

    war.turn.type
    assert_equal true, war.win_condition
  end

  def test_win_condition_turn_count_route
    deck1 = Deck.new
    deck2 = Deck.new
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    war = Game.new(turn)
    war.cut_cards

    assert_equal 0, war.turn_count

    war.debug_turn_count

    assert_equal 1000001, war.turn_count
    assert_equal true, war.win_condition
  end

  def test_turn_result_text_basic
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card8])
    deck2 = Deck.new([card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    war = Game.new(turn)
    war.turn.type
    war.turn.winner
    war.turn.pile_cards
    war.turn.award_spoils

    assert_equal false, war.win_condition
    assert_equal "Turn 0: Aurora won 2 cards", war.turn_result
  end

  def test_turn_result_war
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
    war = Game.new(turn)
    war.turn.type
    war.turn.winner
    war.turn.pile_cards
    war.turn.award_spoils

    assert_equal "Turn 0: WAR - Aurora won 6 cards", war.turn_result
  end
end
