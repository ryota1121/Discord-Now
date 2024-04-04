class RemoveLinkFromServers < ActiveRecord::Migration[6.1]
  def change
    remove_column :servers, :link, :string
  end
end
