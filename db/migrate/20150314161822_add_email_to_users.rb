class AddEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    rename_column :users, :username, :name
  end
end
