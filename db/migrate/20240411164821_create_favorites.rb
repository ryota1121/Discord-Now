class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :server_id

      t.timestamps
      t.index [:user_id, :server_id], unique: true
    end
  end
end
