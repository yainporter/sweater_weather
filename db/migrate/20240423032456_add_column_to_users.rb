class AddColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :api_key, :string
    add_column :users, :api_key_hash, :string

    add_index :users, :api_key, unique: true
  end
end
