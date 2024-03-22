class AddToolToServers < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :tool, :string
  end
end
