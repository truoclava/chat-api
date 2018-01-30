class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.belongs_to :user, index: true
      t.string :token
      t.string :scope
      t.datetime :expires_at

      t.timestamps
    end
    add_index :access_tokens, :token, unique: true
  end
end
