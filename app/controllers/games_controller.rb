class GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy]

  def index
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to game_path(@game)
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @current_player_name = @game.current_player_name
  end

  def update
    if @game.make_move(params[:row].to_i, params[:col].to_i)
      redirect_to game_path(@game), notice: 'Move was successfully made.'
    else
      redirect_to game_path(@game), alert: 'Invalid move!'
    end
  end

  def destroy
    @game.destroy
    redirect_to root_path
  end

  def reset
    @game = Game.find(params[:id])
    

    @game.update(board: Array.new(3) { Array.new(3) })
    @game.update(status: "in progress")
    
    redirect_to game_path(@game)
  end

  private

  def determine_current_player_name(game)
    current_player_index = game.turn % 2
    current_player_name = (current_player_index == 0) ? game.player1_name : game.player2_name
    current_player_name
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:player1_name, :player2_name)
  end
end
