class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer    :sender_id,    null: false, limit: 8, comment: 'bigint活用のため、limit: 8'
      t.integer    :recipient_id, null: false, limit: 8, comment: 'bigint活用のため、limit: 8'
      t.timestamps                null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :likes, %i(sender_id recipient_id), unique: true
  end
end
