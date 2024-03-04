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
      render :index
    end
  end

  def show
    @game = Game.find(params[:id])
    @current_player_name = determine_current_player_name(@game)
  end

  def update
    @game = Game.find(params[:id])
    if @game.make_move(params[:row].to_i, params[:col].to_i, params[:player])
      redirect_to @game
    else
      flash[:error] = "Invalid move!"
      redirect_to @game
    end
  end

  def destroy
    @game.destroy
    redirect_to root_path
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
