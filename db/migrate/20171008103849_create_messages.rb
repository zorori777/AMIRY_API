class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;' do |t|
      t.integer    :sender_id,    null: false, limit: 8, comment: 'bigint活用のため、limit: 8'
      t.integer    :recipient_id, null: false, limit: 8, comment: 'bigint活用のため、limit: 8'
      t.string     :body,         null: false, default: ''
      t.string     :image,        null: false, default: ''
      t.timestamps                null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :messages, :sender_id
    add_index :messages, :recipient_id
  end
end
