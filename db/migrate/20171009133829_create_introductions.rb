class CreateIntroductions < ActiveRecord::Migration[5.1]
  def change
    create_table :introductions do |t|
      t.integer    :sender_id,    null: false, limit: 8, comment: 'bigint活用のため、limit: 8'
      t.integer    :recipient_id, null: false, limit: 8, comment: 'bigint活用のため、limit: 8'
      t.text       :description,  null: false
      t.integer    :acceptance,   null: false, limit: 1, default: 0
      t.timestamps                null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :introductions, %i(sender_id recipient_id), unique: true
  end
end
