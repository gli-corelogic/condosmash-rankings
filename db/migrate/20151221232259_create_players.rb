class CreatePlayers < ActiveRecord::Migration
  def up
    create_table :players do |t|
      t.string :name, :null => false
      t.string :description
      t.integer :rating, :default => 1200
    end
  end

  def down
    drop_table :players
  end
end
