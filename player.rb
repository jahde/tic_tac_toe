class Player
  attr_accessor :name, :symbol  # Each player must have a name and symbol attached.

  def initialize(name, symbol)
    @name = name
    @symbol = symbol   # Symbol represents the game piece, either "X" or "O"
  end

  def say_hello()
    puts "Welcome #{name} you are team #{symbol}! Prepare to battle"
  end
end
