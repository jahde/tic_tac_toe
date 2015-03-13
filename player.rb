class Player
  # Each player must have a name and symbol attached.
  # Symbol represents the game piece, either "X" or "O"
  attr_accessor :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def say_hello()
    puts "Welcome #{name} you are team #{symbol}! Prepare to battle"
  end
end
