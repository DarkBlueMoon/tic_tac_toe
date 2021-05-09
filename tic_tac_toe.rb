WINNING_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
]

class Player
  attr_reader :id, :mark
  def initialize(id, mark)
    @id = id
    @mark = mark
  end
end

class Board
  attr_reader :board
  
  def initialize
    @board = (1..9).to_a
  end

  # Converts the player's 1-9 selection to 0-8 array index.
  def move_to_index(player_move)
    player_move.to_i - 1
  end

  # Returns if the desired move is in an empty space & is between index 0-8.
  def validate_move(player_move)
    converted_move = move_to_index(player_move)
    converted_move.between?(0, 8) && empty?(board[converted_move])
  end

  # Returns if the space is available (has an integer in it.)
  def empty?(space)
    space.is_a?(Integer)
  end

  # Modifies the player's desired space with their mark.
  def update(index, player)
    board[move_to_index(index)] = player.mark
    display
  end

  # Displays the board in a 3x3 grid.
  def display
    puts
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
    puts
  end

  def winner?(player)
    WINNING_COMBINATIONS.any? do |line|
      line.all? { |position| board[position] == player.mark}
    end
  end

  # Reaching this check means the game verified there is no winner yet.
  # The only other options are: board is full or game is still in progress.
  def tie?
    full?
  end

  def full?
    board.none? { |elem| elem.is_a?(Integer) }
  end
end

class Game
  attr_accessor :current_player
  attr_reader :game_board

  def initialize
    @player_one = Player.new(1, 'X')
    @player_two = Player.new(2, 'O')
    @current_player = @player_one
    @game_board = Board.new
    @is_running = true

    self.play_game
  end

  def swap_players
    if current_player == @player_one
      self.current_player = @player_two
    else
      self.current_player = @player_one
    end
  end

  def play_game
    game_board.display
    
    while @is_running do
      puts "Player #{current_player.id} (#{current_player.mark}), please select 1-9."
      choice = gets.chomp.to_i
      
      if (game_board.validate_move(choice))
        game_board.update(choice, current_player)
      else
        puts "Desired space is occupied, please choose 1-9 again."
      end
      
      if (game_board.winner?(current_player))
        puts "Player #{current_player.id} (#{current_player.mark}) is the winner!"
        @is_running = false
      elsif (game_board.tie?)
        puts "Game ends in a tie!"
        @is_running = false
      end

      swap_players()
    end
  end
end

game = Game.new