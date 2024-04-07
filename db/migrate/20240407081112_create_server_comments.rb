class CreateServerComments < ActiveRecord::Migration[6.1]
  def change
    create_table :server_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :server_id

      t.timestamps
    end
  end
end
