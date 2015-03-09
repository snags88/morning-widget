class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :headline
      t.string :url
      t.datetime :article_date
      t.string :source

      t.timestamps null: false
    end
  end
end
