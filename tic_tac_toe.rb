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
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
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

  def empty?(space)
    space == "" || space == " " || space == nil
  end

  def update_board(index, player)
    board[index] = player.mark
  end

  # Displays the board in a 3x3 grid.
  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
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
  attr_accessor :game_board, :current_player
  def initialize(player_one, player_two, game_board)
    @player_one = player_one
    @player_two = player_two
    @current_player = @player_one
    @game_board = game_board
    @is_running = true
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
      game_board.display_board
      puts "Player #{current_player.id} (#{current_player.mark}), please select 1-9."
      choice = gets.chomp.to_i

      if (game_board.validate_move(choice))
        puts "Valid choice!"
        game_board.update_board(choice, @current_player)
        swap_players()
      end
    end
  end
end

board = Board.new
player_one = Player.new(1, 'X')
player_two = Player.new(2, 'O')
game = Game.new(player_one, player_two, board)
game.play_game

# Rules
#   2 players, 'x' and 'o'
#   9 spaces on a 3x3 grid
#   Each player takes turns picking an available slot until there is either a winner or a tie game.





# Game flow
#   Game class checks the board for a winner or a tied game. If neither are true, game is still in progress.
#   Game prompts the current_player to make their move. Displays the board. Player chooses between 1 and 9.
#   Player's move is passed to the board class which converts the move into array indices & validates the move.
#   If the move is valid, board updates that array index with the player's move.
#     Board tells game the move was valid, game switches players, displays board, asks next player for their move.
#   If the move is invalid, board tells the game that the move was invalid, game prompts for another move.