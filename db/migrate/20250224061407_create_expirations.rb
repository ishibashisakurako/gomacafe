class CreateExpirations < ActiveRecord::Migration[6.1]
  def change
    create_table :expirations do |t|
      t.string :name
      t.datetime :start_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
