class Game < ApplicationRecord
  serialize :board, Array, coder: JSON

  validates :player1_name, :player2_name, presence: true

  before_validation :initialize_board, on: :create
  after_initialize :set_default_turn, if: :new_record?

  def set_default_turn
    self.turn ||= 0
    self.status = nil # Set status to nil when initializing a new game
  end

  def current_player_name
    turn.even? ? player2_name : player1_name
  end

  def current_player_symbol
    turn.even? ? 'X' : 'O'
  end

  def make_move(row, col)
    return false if board[row][col].present? # If the cell is already occupied, it's an invalid move
    
    # Update the board with the current player's symbol
    board[row][col] = current_player_symbol

    # Increment turn before checking for a win or draw
    self.turn += 1

    # Check for winning condition or draw
    update_status if check_winner || board_full?

    save
    true
  end

  def player1_symbol
    'X'
  end
  
  def player2_symbol
    'O'
  end

  private

  def initialize_board
    self.board = Array.new(3) { Array.new(3) }
  end

  def check_winner
    winning_patterns = [
      [[0, 0], [0, 1], [0, 2]], # Top row
      [[1, 0], [1, 1], [1, 2]], # Middle row
      [[2, 0], [2, 1], [2, 2]], # Bottom row
      [[0, 0], [1, 0], [2, 0]], # Left column
      [[0, 1], [1, 1], [2, 1]], # Middle column
      [[0, 2], [1, 2], [2, 2]], # Right column
      [[0, 0], [1, 1], [2, 2]], # Top-left to bottom-right diagonal
      [[0, 2], [1, 1], [2, 0]]  # Top-right to bottom-left diagonal
    ]

    winning_patterns.each do |combination|
      symbols = combination.map { |row, col| board[row][col] }
      return symbols[0] if symbols.uniq.size == 1 && symbols[0].present? # Return the winning symbol if all cells in a combination have the same symbol
    end

    nil
  end

  def update_status
    self.status = "#{current_player_name} wins!" if check_winner
    self.status = "It's a draw!" if board_full? && status.nil? # Set draw status if no winner and board is full
  end

  def board_full?
    board.flatten.all?
  end
end
