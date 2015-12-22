class CreateMatches < ActiveRecord::Migration[5.0]
  def up
    create_table :matches do |t|
      t.integer :player_a_id, :null => false
      t.integer :player_b_id, :null => false
      t.integer :player_a_score, :null => false
      t.integer :player_b_score, :null => false
      t.integer :player_a_rating_delta, :null => false
      t.integer :player_b_rating_delta, :null => false
      t.datetime :created_at, :null => false
    end
  end

  def down
    drop_table :matches
  end
end
