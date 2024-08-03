class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics do |t|
      t.string :title
      t.text :description
      t.string :cover_url
      t.integer :marvel_id

      t.timestamps
    end
  end
end
