WINNING_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
]

# "Player"
#   will have an ID (1 or 2) and a mark ('x' or 'o')
#   gives its moves as a #, 1-9, which will be converted to array indices (0-8)
#   passes its move to the board class, which will update the board if the move is valid
class Player
  attr_reader :id, :mark
  def initialize(id, mark)
    @id = id
    @mark = mark
  end
end

# "Board"
#   an array with 9 spaces, indexed 0-8
#   holds the game board var itself
#   converts player-passed move into array index
#   validates player moves: valid if space is free & moves index is between 0-8
#   modify board index w/ valid move
#   displays board in 3x3 grid
#   will likely need access to current player.
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

  def winner?

  end

  def tie?
    !winner? && full?
  end

  def full?
    board.none? { |elem| elem.is_a?(Integer) }
  end
end

# "Game"
#   should have readonly access to the board
#   should have readonly access to the players
#   loops until the game is over, prompting users to take their 'turn'
#   checks, after each 'turn', for whether there's a winner, a tied game, or a game in progress
#   stores winning combinations and checks the board for these.
#   displays the result of the game
#   keeps track of the current player
#   swaps the current player after each move is made.
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
    
    while @is_running do
      
      game_board.display
      puts "Player #{current_player.id} (#{current_player.mark}), please select 1-9."
      choice = gets.chomp.to_i
      
      if (game_board.validate_move(choice))
        # puts "Valid choice!"
        game_board.update(choice, current_player)
      else
        puts "Desired space is occupied, please choose 1-9 again."
      end
      
      if (game_board.winner?)
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

# Game flow
#   Game class checks the board for a winner or a tied game. If neither are true, game is still in progress.
#   Game prompts the current_player to make their move. Displays the board. Player chooses between 1 and 9.
#   Player's move is passed to the board class which converts the move into array indices & validates the move.
#   If the move is valid, board updates that array index with the player's move.
#     Board tells game the move was valid, game switches players, displays board, asks next player for their move.
#   If the move is invalid, board tells the game that the move was invalid, game prompts for another move.