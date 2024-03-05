require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#make_move' do
    context 'when there is a winner' do
      it 'declares player 1 as the winner if they have three symbols in a row' do
        game = Game.new(player1_name: 'a', player2_name: 'b')
        game.board = [['X', 'X', 'X'], ['O', nil, 'O'], [nil, 'X', 'O']]
        expect { game.make_move(2, 0) }.to change { game.status }.from(nil).to('a wins!')
      end

      it 'declares player 2 as the winner if they have three symbols in a column' do
        game = Game.new(player1_name: 'a', player2_name: 'b')
        game.board = [['X', 'O', 'X'], ['O', 'X', 'O'], ['X', 'O', nil]]
        expect { game.make_move(2, 2) }.to change { game.status }.from(nil).to('a wins!')
      end

      it 'declares player 1 as the winner if they have three symbols in a diagonal' do
        game = Game.new(player1_name: 'a', player2_name: 'b')
        game.board = [['X', 'O', 'X'], ['O', 'X', 'O'], ['X', nil, 'X']]
        expect { game.make_move(2, 1) }.to change { game.status }.from(nil).to('a wins!')
      end
    end
  end
end
