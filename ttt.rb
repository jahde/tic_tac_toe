require_relative 'player'
require_relative 'board'

class Game
  attr_accessor :grid, :player1, :player2

  # initialize a new board for the game
  def initialize
    @grid = Board.new
    @nums = [] # initialized for the check_integer method to collect chosen positions
  end

  def play
    new_players
    welcome_message
    go_play
    make_moves
  end

  # gets the information from the players including name and auto-generated symbol of x or o
  def new_players
    puts "Welcome to the Tic Tac Toe Game X-O-X-O"
    puts "Player 1 name:"
    name1 = gets.chomp
    @player1 = Player.new(name1, "X") #creates player 2 with X symbol
    @player1.say_hello  # prints out welcome message for player 1
    puts "Player 2 name:"
    name2 = gets.chomp
    @player2 = Player.new(name2, "O") #creates player 2 with O symbol
    @player2.say_hello  # prints out welcome message for player 2
  end

  # welcomes players to the game and creates a blank grid to show
  def welcome_message
    puts "\n"
    puts "The object of the game is to get three spots in a row, diagonally/horizontally/vertically"
    puts "Use the numbers from 1-9 to select your position:"
    puts "\n"
    (1..9).each_slice(3) {|a| puts a.join(' | ')}   # sample layout of grid to show the relevant numbers matched to the cell
    puts "\n"
  end

  # starts the game by printing out the blank board
  def go_play
    puts "Let's start a new game"
    @grid.print_board   # prints the initial blank layout of the board
    puts @player1.name + " " + "your turn first!"  # player 1 always goes first
  end

  def make_moves
    # iterates through 9 possible moves alternating between players
    puts "\n"
    i = 0
    while i < 9
      puts "Turn " + (i+1).to_s + ":"   #shows which turn the game is on
        i.to_i.even? ? player_move("X") : player_move("O")   # counter to switch between players
      i += 1
    end
  end

  def player_move(board_symbol)  # player movement is based on their symbol of X or O
    puts "Choose your position:"
    check_for_integer
    @fposition = @position - 1  # position minus one for the indexed array pos
    @grid.update_board(@fposition, board_symbol) #update the board with new position and symbol
    @last_move = board_symbol  # collect the symbol of the last move to recognize which player just picked
    @new_grid = @grid.display_board  # returns the new board after the player chooses their position
    check_for_winner   # checks if this was a winning move
  end

  def check_for_integer # picks new number **
    input = gets.chomp.to_i # retrieves player moves and changes to integer value

    if @nums.include?(input)  # checks if selected number has already been picked
      puts "That position has already been picked. Pick another!"
      check_for_integer  #using recursion to make sure they pick a number that hasn't been picked
    elsif input.between?(1,9)  # input can only be from 1-9
      @position = input  # creates a variable @position that stores the selected number from the user
      @nums.push(input)  # adds input to the array of selected positions
    else
      puts "You must pick a number between 1 and 9"
      check_for_integer  #using recursion to make sure they pick a number 1-9
    end
  end

  def check_for_winner # finding the correct combination  **
    # array of all possible 3 element winning combinations from the grid
    winning = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    winning.each do |arr|  # iterate through each winning set
      if arr.all? {|num| @new_grid[num] == @last_move }  # if all values of the chosen set equal the player's symbol = WINNER
        announce_winner
        exit  # exit out of the program once we have a winner
      else
        next
      end
    end
  end

  def announce_winner
    puts "CONGRATULATIONS " + @player1.name + "! You won, GAME OVER" if (@last_move == "X")
    puts "CONGRATULATIONS " + @player2.name + "! You won, GAME OVER" if (@last_move == "O")
  end
end

new_game = Game.new
new_game.play



