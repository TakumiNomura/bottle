class AddColumnToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :anc_id, :integer
  end
end
