class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :identities, :users
  end
end
