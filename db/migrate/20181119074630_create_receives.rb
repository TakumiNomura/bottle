class CreateReceives < ActiveRecord::Migration[5.2]
  def change
    create_table :receives do |t|
      t.integer :u_id
      t.integer :mes_id

      t.timestamps
    end
  end
end
