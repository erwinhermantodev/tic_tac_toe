FactoryBot.define do
  factory :game do
    player1_name { "Player 1" }
    player2_name { "Player 2" }
    status { "in_progress" }
    board { Array.new(3) { Array.new(3) } }
  end
end
  