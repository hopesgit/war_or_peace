require "./lib/card"
require "./lib/deck"
require "./lib/player"
require "./lib/turn"

class Game
  attr_reader :turn
  
  def initialize(turn)
    @turn = turn
  end
end
