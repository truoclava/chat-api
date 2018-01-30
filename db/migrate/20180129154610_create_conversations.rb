class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :seller, index: true
      t.references :buyer, index: true
      t.datetime :last_activity_at
      
      t.timestamps
    end
  end
end
