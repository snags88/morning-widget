class CreateUserSubways < ActiveRecord::Migration
  def change
    create_table :user_subways do |t|
      t.references :user, index: true
      t.references :subway, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_subways, :users
    add_foreign_key :user_subways, :subways
  end
end
