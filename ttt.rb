# players, board, position, win/loss track

puts "hi this my game"

class Player
  # def initialize(name, type)
  #   Player.new
  # end

  def new_player
    puts "what is your name?"
    @player = gets.chomp
    puts @player + " " + "get ready for battle!"
    Player.new_player
  end
end

class Board
end

class Game
end

Player.new
