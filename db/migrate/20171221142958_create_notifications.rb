class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer    :user_id,           unsigned: true, null: false
      t.integer    :target_model_type, unsigned: true, null: false, default: 0, limit: 1
      t.integer    :target_model_id,   unsigned: true, null: false, default: 0
      t.string     :body,                              null: false, default: ''
      t.integer    :status,            unsigned: true, null: false, default: 0, limit: 1
      t.timestamps                                     null: false
    end

    add_index :notifications, :user_id
  end
end
