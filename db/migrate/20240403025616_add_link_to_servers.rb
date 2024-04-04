class AddLinkToServers < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :link, :string
  end
end
