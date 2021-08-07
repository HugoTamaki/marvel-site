class AddSoldAtFieldToComics < ActiveRecord::Migration[6.1]
  def change
    add_column :comics, :sold_at, :datetime
  end
end
