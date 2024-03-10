class AddUserIdToServers < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :user_id, :integer
  end
end
