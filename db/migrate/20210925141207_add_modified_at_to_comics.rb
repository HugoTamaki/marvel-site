class AddModifiedAtToComics < ActiveRecord::Migration[6.1]
  def change
    add_column :comics, :modified_at, :datetime, after: :thumbnail, default: nil
  end
end
