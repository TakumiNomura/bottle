class ChengeNotNullToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :posts, :read_flag, false
    change_column :posts, :read_flag, :boolean, default: false
  end
end
