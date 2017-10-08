class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;' do |t|
      t.integer    :sender_id,    null: false, limit: 8, comment: 'bigint活用のため、limit: 8'
      t.integer    :recipient_id, null: false, limit: 8, comment: 'bigint活用のため、limit: 8'
      t.string     :body,         null: false, default: 'NO BOBY'
      t.string     :image,        null: false, default: 'NO IMAGE'
      t.timestamps                null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_foreign_key :messages, :users, column: :sender_id
    add_foreign_key :messages, :users, column: :recipient_id
  end
end
