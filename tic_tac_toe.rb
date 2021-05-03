require 'pry'

WINNING_COMBINATIONS = [
  [1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]
]

class Game
  attr_accessor :current_player
  attr_reader :is_running

  def initialize
    @board = [[1,2,3], [4,5,6], [7,8,9]]
    @player_one = {id: 1, mark: 'x'}
    @player_two = {id: 2, mark: 'o'}
    @current_player = @player_one
    @is_running = true
  end

  # Display game board as 3x3
  def display_board
    @board.each do |row|
      p row.each { |elem| elem }.join(' ')
    end
  end

  def update_board(choice)
    puts "Board updated with #{choice} by Player #{current_player[:id]}."
  end

  def swap_players(curr_player)
    
    if curr_player == @player_one
      self.current_player = @player_two
    else
      self.current_player = @player_one
    end
  end

  def start_game
    while is_running do 
      display_board

      puts "Player #{current_player[:id]} (#{current_player[:mark]}), please select an empty spot (1 - 9)."
      player_choice = gets.chomp.to_i

      until player_choice >= 1 && player_choice <= 9
        puts "Invalid choice! Only choose 1 - 9."
        player_choice = gets.chomp.to_i
      end

      update_board(player_choice)
      swap_players(current_player)
    end
  end
end

game = Game.new

game.start_game