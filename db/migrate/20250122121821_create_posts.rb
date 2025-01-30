class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.string :title
      t.text :material
      t.text :recipe
      t.text :point
      t.references :user, null: false, foreigh_key: true

      t.timestamps
    end
  end
end
