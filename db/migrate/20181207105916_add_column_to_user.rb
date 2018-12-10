class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :report_count, :integer, :default => 0
  end
end
