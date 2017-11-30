class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer    :university_id,            unsigned: true, null: false
      t.integer    :facebook_id,              unsigned: true, null: false, default: 0
      t.string     :facebook_token,                           null: false, default: ''
      t.integer    :facebook_toke_expires_at, unsigned: true, null: false, default: 0
      t.string     :first_name,                               null: false, default: ''
      t.string     :last_name,                                null: false, default: ''
      t.string     :display_name,                             null: false, default: ''
      t.string     :email,                                    null: false, default: ''
      t.string     :avatar,                                   null: false, default: ''
      t.string     :catch_copy,                               null: false, default: ''
      t.text       :self_introduction,                        null: false
      t.integer    :bands_count,              unsigned: true, null: false, default: 0
      t.integer    :received_likes_count,     unsigned: true, null: false, default: 0
      t.integer    :sendable_likes_count,     unsigned: true, null: false, default: 0
      t.integer    :matchings_count,          unsigned: true, null: false, default: 0
      t.integer    :account_status,           unsigned: true, null: false, default: 0
      t.timestamps                                            null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :users, :university_id
    add_index :users, :email,        unique: true
    add_index :users, :facebook_id,  unique: true
  end
end
