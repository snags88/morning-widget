class CreateSubways < ActiveRecord::Migration
  def change
    create_table :subways do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
