class CreateFavourites < ActiveRecord::Migration[6.1]
  def change
    create_table :favourites do |t|
      t.integer :user_id
      t.integer :comic_id

      t.timestamps
    end

    add_index :favourites, :user_id
    add_index :favourites, :comic_id
  end
end
