# players, board, position, win/loss track
class Game
  attr_accessor :grid, :player1, :player2, :computer

  # initialize a new board for the game
  def initialize
    @grid = Board.new
    @computer = Player.new("computer", "O")
  end

  def play
    new_players
    welcome_message
    go_play
    continue_play
    # show_result
    # show_game_over_message
  end

  # gets the information from the players including name and auto-generated symbol of x or o
  def new_players
    puts "Welcome to the Tic Tac Toe Game X-O-X-O"
    players = []
    puts "Player 1 name:"
    name1 = gets.chomp
    @player1 = Player.new(name1, "X")
    @player1.say_hello
    players << player1
    puts "Player 2 name:"
    name2 = gets.chomp
    @player2 = Player.new(name2, "O")
    @player2.say_hello
    players << player2
  end

  # welcomes players to the game and creates a blank grid to show
  def welcome_message
    puts "\n"
    puts "The object of the game is to get three spots in a row, diagonally/horizontally/vertically"
    puts "Use the numbers from 1-9 to select your position:"
    puts "\n"
    # sample layout of grid to show the relevant numbers matched to the cell
    (1..9).each_slice(3) {|a| puts a.join(' | ')}
    puts "\n"
  end

  # starts the game by printing out the blank board
  def go_play
    puts "Let's start a new game"
    @grid.print_board
    puts @player1.name + " " + "your turn first!"
  end

  def continue_play
    puts "\n"
    i = 0
    while i < 9
      puts "Turn " + (i+1).to_s + ":"
        puts "Choose your position:"
        @position = gets.chomp
        @fposition = @position.to_i - 1
        @grid.update_board(@fposition)
      i += 1
    end
  end
end

class Player
  # Each player must have a name and symbol attached.
  # Symbol represents the playing card, either "X" or "O"
  attr_accessor :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def say_hello()
    puts "Welcome #{name} you are team #{symbol}! Prepare to battle"
  end

end

class Board
  attr_reader :board, :empty_cell


  def initialize
    @empty_cell = '-' # board starts with all empty cells
    @board = Array.new(9, @empty_cell) # create a board with 9 empty cells
  end

  def print_board # prints a new blank board each time
    puts "\n"
    @board.each_slice(3) {|a| puts a.join(' | ')}
    puts "\n"
  end

  # updates the board with the relevant positions
  def update_board(pos)
    @board[pos] = "X"
    print_board
  end
end

new_game = Game.new
new_game.play



