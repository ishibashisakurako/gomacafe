class AddStatusToColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :columns, :status, :integer, default: 0, null: false
  end
end
