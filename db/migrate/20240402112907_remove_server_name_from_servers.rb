class RemoveServerNameFromServers < ActiveRecord::Migration[6.1]
  def change
    remove_column :servers, :server_name, :string
  end
end
