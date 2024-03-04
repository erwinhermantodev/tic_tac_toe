# app/models/game.rb
class Game < ApplicationRecord
  serialize :board, Array, coder: JSON

  validates :player1_name, :player2_name, presence: true

  before_validation :initialize_board, on: :create

  after_initialize :set_default_turn, if: :new_record?

  def set_default_turn
    self.turn ||= 0
  end

  def current_player_name
    turn.even? ? player1_name : player2_name
  end

  def make_move(row, col, player)
    return false if board[row][col] # If the cell is already occupied, it's an invalid move
    
    # Update the board with the player's symbol
    board[row][col] = (player == player1_name) ? 'X' : 'O'

    # Check for winning condition
    if check_winner
      self.status = "#{player} wins!"
      save
    elsif board_full?
      self.status = "It's a draw!"
      save
    else
      save
    end

    true
  end

  private

  def initialize_board
    self.board = Array.new(3) { Array.new(3) }
  end

  def check_winner
    # Check rows
    board.each do |row|
      return true if row.uniq.length == 1 && !row[0].nil?
    end

    # Check columns
    (0..2).each do |col|
      column = [board[0][col], board[1][col], board[2][col]]
      return true if column.uniq.length == 1 && !column[0].nil?
    end

    # Check diagonals
    diagonals = [
      [board[0][0], board[1][1], board[2][2]],
      [board[0][2], board[1][1], board[2][0]]
    ]
    diagonals.each do |diag|
      return true if diag.uniq.length == 1 && !diag[0].nil?
    end

    false
  end

  def board_full?
    board.flatten.all?
  end

  def player_symbol(player_name)
    player_name == player1_name ? 'X' : 'O'
  end
end
