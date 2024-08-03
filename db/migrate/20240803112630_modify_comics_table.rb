class ModifyComicsTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :comics, :description, :text
    remove_column :comics, :marvel_id, :integer
    add_column :comics, :upvotes, :integer, default: 0
  end
end
