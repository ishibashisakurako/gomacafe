class AddAmountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :amount, :string
  end
end
