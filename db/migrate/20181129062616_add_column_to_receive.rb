class AddColumnToReceive < ActiveRecord::Migration[5.2]
  def change
    add_column :receives, :reply_flag, :boolean, :null => false, :default => false
  end
end
