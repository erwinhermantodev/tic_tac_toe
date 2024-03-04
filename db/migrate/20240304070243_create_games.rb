class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :player1_name
      t.string :player2_name
      t.text :board, default: Marshal.dump(Array.new(3) { Array.new(3) })
      t.string :status, default: "In Progress"

      t.timestamps
    end
  end
end
