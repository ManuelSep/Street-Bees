class AddMarvelIdToComics < ActiveRecord::Migration[6.1]
  def change
    add_column :comics, :marvel_id, :integer
  end
end
