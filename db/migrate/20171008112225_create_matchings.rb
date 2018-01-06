class CreateMatchings < ActiveRecord::Migration[5.1]
  def change
    create_table :matchings do |t|
      t.integer    :like_id,      unsigned: true, null: false
      t.integer    :sender_id,    unsigned: true, null: false
      t.integer    :recipient_id, unsigned: true, null: false
      t.timestamps                                null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :matchings, :like_id
    add_index :matchings, %i(sender_id recipient_id), unique: true
  end
end
