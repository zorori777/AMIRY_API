class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer    :university_id,         null: false
      t.string     :first_name,            null: false, default: ''
      t.string     :last_name,             null: false, default: ''
      t.string     :display_name,          null: false, default: ''
      t.string     :email,                 null: false, default: ''
      t.string     :avatar,                null: false, default: ''
      t.string     :catchcopy,             null: false, default: ''
      t.text       :self_introduction,     null: false
      t.integer    :bands_count,           null: false, default: 0
      t.integer    :received_likes_count,  null: false, default: 0
      t.integer    :sendable_likes_count,  null: false, default: 0
      t.integer    :matchings_count,       null: false, default: 0
      t.integer    :account_status,        null: false, default: 0
      t.timestamps                         null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :users, :display_name, unique: true
    add_index :users, :email,        unique: true
  end
end
