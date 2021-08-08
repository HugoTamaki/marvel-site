class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :cookie_hash
      t.datetime :expires_at

      t.timestamps
    end
  end
end
