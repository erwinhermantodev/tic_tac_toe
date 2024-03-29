# spec/controllers/games_controller_spec.rb
require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "POST #create" do
    context "with invalid parameters" do
      it "does not create a game and responds with unprocessable entity" do
        expect {
          post :create, params: { game: { player1_name: nil, player2_name: nil } }
        }.not_to change(Game, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    let!(:game) { Game.create!(player1_name: "Alice", player2_name: "Bob") }

    it 'assigns the requested game to @game and renders the show template' do
      get :show, params: { id: game.id }
      expect(assigns(:game)).to eq(game)
      expect(response).to render_template(:show)
    end
  end

  describe 'PATCH #update' do
    let!(:game) { Game.create!(player1_name: "Alice", player2_name: "Bob") }

    context 'with valid move' do
      it 'updates the game and redirects' do
        patch :update, params: { id: game.id, row: 0, col: 0 }
        expect(response).to redirect_to(game_path(game))
        expect(flash[:notice]).to eq('Move was successfully made.')
      end
    end

    context 'with invalid move' do
      it 'does not update the game and redirects with an alert' do
        # Assuming make_move will return false for an invalid move
        allow_any_instance_of(Game).to receive(:make_move).and_return(false)
        patch :update, params: { id: game.id, row: 0, col: 0 }
        expect(response).to redirect_to(game_path(game))
        expect(flash[:alert]).to eq('Invalid move!')
      end
    end
  end

  describe "POST #reset" do
    let(:game) { FactoryBot.create(:game) }

    it "resets the game board and updates status to 'in progress'" do
      # Call the reset action
      post :reset, params: { id: game.id }

      # Reload the game to get the updated attributes from the database
      game.reload

      # Check if the game's board is reset to an empty state
      expect(game.board).to eq(Array.new(3) { Array.new(3) })

      # Check if the game status is updated to 'in progress'
      expect(game.status).to eq("in progress")

      # Check if the controller redirects to the game details page
      expect(response).to redirect_to(game_path(game))
    end
  end
end
