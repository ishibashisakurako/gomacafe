class AddOtherToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :other_id, :integer
  end
end
