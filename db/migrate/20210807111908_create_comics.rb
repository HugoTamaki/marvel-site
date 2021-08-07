class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics do |t|
      t.integer :comic_id
      t.string :title
      t.text :description
      t.string :comic_url
      t.string :thumbnail

      t.timestamps
    end
  end
end
