WINNING_COMBINATIONS = [
  [1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]
]

class Game
  def initialize
    # @board = [[1,2,3], [4,5,6], [7,8,9]]
    @board = Array.new(3, Array.new(3, "empty"))
    @player_one = {id: 1, mark: 'x'}
    @player_two = {id: 2, mark: 'o'}
    @current_player = @player_one
    is_running = true
  end

  # Display game board as 3x3
  def display_board
    @board.each do |row|
      p row.each { |elem| elem }.join(' ')
    end
  end

  # For now, player one always goes first.
  # TODO (maybe): have starting player be randomly selected.
  def start_game
    # While is_running is true:

    # Display game board
    # display_board
    # Prompt current player to select 1 - 9
    # Format: current_player (markhere), make your move: 1 - 9

    # Add player's mark to the board in that position
  end
end

game = Game.new

game.display_board