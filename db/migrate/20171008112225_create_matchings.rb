class CreateMatchings < ActiveRecord::Migration[5.1]
  def change
    create_table :matchings do |t|
      t.integer    :sender_id,    null: false, limit: 8, comment: 'bigint活用のため、limit: 8'
      t.integer    :recipient_id, null: false, limit: 8, comment: 'bigint活用のため、limit: 8'
      t.timestamps                null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_foreign_key :matchings, :users, column: :sender_id
    add_foreign_key :matchings, :users, column: :recipient_id
  end
end
