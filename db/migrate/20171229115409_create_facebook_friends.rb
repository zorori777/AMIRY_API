class CreateFacebookFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :facebook_friends do |t|
      t.integer    :user_id,     unsigned: true, null: false, limit: 8
      t.integer    :facebook_id, unsigned: true, null: false, limit: 8, default: 0
      t.timestamps                               null: false
    end

    add_index :facebook_friends, %i(user_id facebook_id), unique: true
  end
end
