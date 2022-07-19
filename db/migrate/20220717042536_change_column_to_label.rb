class ChangeColumnToLabel < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :labels, :users
  end
end
