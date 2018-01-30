class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :messages, :read_by_id, :recipient_id
  end
end
