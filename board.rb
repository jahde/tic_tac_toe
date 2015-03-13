class Board
  attr_reader :board, :empty_cell

  def initialize
    @board = Array.new(9, '-') # create a board with 9 empty cells
  end

  def print_board # prints a new blank board for the first time
    puts "\n"
    @board.each_slice(3) {|a| puts a.join(' | ')}  # creates slice of 3 elements and separates them with | for the look of a tic-tac-toe board
    puts "\n"
  end

  def update_board(pos, sym) # updates the board with the relevant positions and symbols
    @board[pos] = sym   # Find the pos-th element of @board and update it with the sym
    print_board  # prints updated board
  end

  def display_board
    @board
  end
end
