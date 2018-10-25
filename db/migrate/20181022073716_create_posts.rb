class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :message
      t.integer :src_id
      t.integer :dst_id
      t.boolean :read_flag


      t.timestamps
    end
  end
end
