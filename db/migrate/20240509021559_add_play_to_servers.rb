class AddPlayToServers < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :play, :datetime
  end
end
