class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.string :zipcode

      t.timestamps null: false
    end
  end
end
