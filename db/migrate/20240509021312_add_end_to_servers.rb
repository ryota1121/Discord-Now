class AddEndToServers < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :end, :datetime
  end
end
