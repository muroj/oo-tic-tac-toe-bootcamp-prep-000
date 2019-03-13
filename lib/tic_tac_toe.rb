class TicTacToe
  
  WIN_COMBINATIONS = [
    [0, 1, 2], # Row wins
    [3, 4, 5], 
    [6, 7, 8], 
    [0, 3, 6], # Column wins
    [1, 4, 7], 
    [2, 5, 8], 
    [0, 4, 8], # Diagonal wins 
    [2, 4, 6] 
  ]

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end
  
  #
  # Prints the tic-tac-toe board to stdout
  #
  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  #
  # Converts the user input string to an integer and normalizes to zero-index 
  #
  # @param <user_input> - string containing user input
  def input_to_index(user_input)
    return user_input.to_i() - 1
  end
  
  #
  # Enters the specified <player> into the specified position on the board.
  #
  # @param <move_position> - index of next move, should be in range 0-8
  # @param <player> - string with value "X" or "O"
  #
  def move(move_position, player="X")
    @board[move_position] = player
  end
  
  #
  # Determines whether the specified index represents a valid position on the game board
  #
  def position_taken?(index)
    position = @board[index]
    
    if !(position.nil? || position.eql?(" ") || position.empty?)
      return (position.eql?("X") || position.eql?("O"))
    else
      return false
    end
  end
  
  #
  # Returns true if <index> is a valid position
  #
  # @param <index> - user input
  #
  def valid_move?(index)
    return index.between?(0, @board.length) && !position_taken?(@board, index)
  end
  
  def turn()
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player())
      display_board()
    else
      turn()
    end
  end
  
  def turn_count(board)
    turns = 0
    
    board.each do |position|
      if position.eql?("X") || position.eql?("O")
        turns += 1
      end
    end
    
    return turns
  end 
  
  def current_player(board)
    # Assume player X goes first
    return turn_count(board) % 2 == 0 ? "X" : "O"
  end
  
  # Define your play method below
  def play(board)
    
    while !over?(board)
      turn(board)
    end
    
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  
  end
  
  def won?(board)
    WIN_COMBINATIONS.each do |winc|
      if (board[winc[0]].eql?("X") && board[winc[1]].eql?("X") && board[winc[2]].eql?("X")) || (board[winc[0]].eql?("O") && board[winc[1]].eql?("O") && board[winc[2]].eql?("O"))
        return winc
      end
    end
    return false
  end 
  
  def full?(board)
    board.all? do |position|
      !(position.nil? || position == " ")
    end
  end
  
  def draw?(board)
    !won?(board) && full?(board)
  end
  
  def over?(board)
    won?(board) || draw?(board)
  end
  
  def winner(board)
    win_combo = won?(board)
    win_combo ? board[win_combo[0]] : nil
  end
  
end # End TicTacToe class