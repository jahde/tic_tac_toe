# players, board, position, win/loss track
class Game
  attr_accessor :grid, :player1, :player2, :computer

  #@winning = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  # initialize a new board for the game
  def initialize
    @grid = Board.new
    @computer = Player.new("computer", "O")
    @nums = [] # initialized for the check_integer method
  end

  def play
    new_players
    welcome_message
    go_play
    continue_play
  end

  # gets the information from the players including name and auto-generated symbol of x or o
  def new_players
    puts "Welcome to the Tic Tac Toe Game X-O-X-O"
    puts "Player 1 name:"
    name1 = gets.chomp
    @player1 = Player.new(name1, "X")
    @player1.say_hello
    puts "Player 2 name:"
    name2 = gets.chomp
    @player2 = Player.new(name2, "O")
    @player2.say_hello
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
    make_moves
  end

  def make_moves
    # iterates through 9 possible moves alternating between players
    puts "\n"
    i = 0
    while i < 9
      puts "Turn " + (i+1).to_s + ":"
        # counter to switch between players
        i.to_i.even? ? player_move("X") : player_move("O")
      i += 1
    end
  end

  def player_move(board_symbol)
    puts "Choose your position:"
    check_for_integer
    @fposition = @position - 1  # position minus one for the indexed array pos
    @grid.update_board(@fposition, board_symbol) #update the board with position and symbol
    @last_move = board_symbol
    @new_grid = @grid.display_board
    check_for_winner
  end

  def check_for_integer # picks new number ** array keeps resetting
    input = gets.chomp.to_i # retrieves player moves

    if @nums.include?(input)  # checks if selected number has already been picked
      puts "That position has already been picked. Pick another!"
      check_for_integer  #using recursion to make sure they pick a number that hasn't been picked
    elsif input.between?(1,10)
      @position = input
      @nums.push(input)  # adds input to the array of selected numbers
    else
      puts "You must pick a number between 1 and 9"
      check_for_integer  #using recursion to make sure they pick a number 1-9
    end
  end

  def check_for_winner # ** finding the correct combination
    winning = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    # gets all possible 3 element combinations from the grid

    winning.each do |arr|  # iterate through each winning set
      if arr.all? {|num| @new_grid[num] == @last_move }  # if all values of the chosen set equal the player's symbol = WINNER
        announce_winner
        #puts "You won, GAME OVER!"
        exit  # exit out of the program once we have a winner
      else
        next
      end
    end

    # @@winning.each do |arr|
    #   arr.each do |n|
    #     if @grid[n] == @last_move
    #       puts "we have a winner"
    #       break
    #     else
    #     end
    #     # @grid[n] = @pos
    #     # next if @pos == @last_move
    #     # break if @pos != @last_move
    #   end
    # end
  end

  def announce_winner
    puts "CONGRATULATIONS " + @player1.name + "! You won, GAME OVER" if (@last_move == "X")
    puts "CONGRATULATIONS " + @player2.name + "! You won, GAME OVER" if (@last_move == "O")
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
    @board = Array.new(9, '-') # create a board with 9 empty cells
  end

  def print_board # prints a new blank board for the first time
    puts "\n"
    @board.each_slice(3) {|a| puts a.join(' | ')}
    puts "\n"
  end

  def update_board(pos, sym) # updates the board with the relevant positions and symbols
    @board[pos] = sym
    @board
    print_board
  end

  def display_board
    #puts "\n"
    @board
    #puts "\n"
  end
end

new_game = Game.new
new_game.play



