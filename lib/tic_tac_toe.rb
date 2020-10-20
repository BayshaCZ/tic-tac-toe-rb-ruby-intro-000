def position_taken?(board, index)
  (board[index] == "X" || board[index] == "O")
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.detect do | win_combination |
    ( board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X") || \
    ( board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O")
  end
end

def full?(board)
  turn_count(board) == 9
end

def draw?(board)
  full?(board) && !(won?(board))
end

def over?(board)
  (won?(board) != nil) || (full?(board) == true)
end

def winner(board)
  win_combination = won?(board)
  unless win_combination == nil
    board[win_combination[0]]
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    current_player = current_player(board)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do | position |
    if (position == "O" || position == "X")
      counter += 1
    end
  end
  counter
end

def current_player(board)
  player = nil
  if turn_count(board).even?
    player = "X"
  else
    player = "O"
  end
  return player
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?
    puts "Congratulations #{winner(board)}!"
  elsif draw?
    puts "Cat\'s Game!"
  end
end
