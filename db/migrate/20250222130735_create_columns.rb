class CreateColumns < ActiveRecord::Migration[6.1]
  def change
    create_table :columns do |t|

      t.string :title
      t.text :body
      t.timestamps
      t.integer :user_id
    end
  end
end
