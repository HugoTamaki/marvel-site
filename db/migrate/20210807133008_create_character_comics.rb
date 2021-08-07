class CreateCharacterComics < ActiveRecord::Migration[6.1]
  def change
    create_table :character_comics do |t|
      t.integer :comic_id
      t.integer :character_id

      t.timestamps
    end

    add_index :character_comics, :comic_id
    add_index :character_comics, :character_id
  end
end
