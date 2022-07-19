class RemoveUserIdFromLabels < ActiveRecord::Migration[6.0]
  def change
    remove_column :labels, :user_id, :bigint
  end
end
