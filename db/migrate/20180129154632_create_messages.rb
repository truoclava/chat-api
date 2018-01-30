class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :conversation, index: true
      t.references :sender, index: true
      t.references :read_by, index: true
      t.datetime   :sent_at
      t.datetime   :read_at
      t.boolean    :read, default: false
      t.text       :body

      t.timestamps
    end
  end
end
