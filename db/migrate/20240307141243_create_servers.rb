class CreateServers < ActiveRecord::Migration[6.1]
  def change
    create_table :servers do |t|
      t.string :game_name
      t.string :server_name
      t.string :title
      t.text :body
      t.timestamps
    end
  end
end
