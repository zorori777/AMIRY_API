class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;' do |t|
      t.references :university,            null: false, foreign_key: true
      t.string     :first_name,            null: false, default: ''
      t.string     :last_name,             null: false, default: ''
      t.string     :display_name,          null: false, default: ''
      t.string     :email,                 null: false, default: ''
      t.string     :encrypted_password,    null: false, default: ''
      t.string     :avatar,                null: false, default: ''
      t.string     :catchcopy,             null: false, default: ''
      t.text       :self_introduction,     null: false
      t.integer    :bands_count,           null: false, default: 0
      t.integer    :received_likes_count,  null: false, default: 0
      t.integer    :sendable_likes_count,  null: false, default: 0
      t.integer    :matchings_count,       null: false, default: 0
      t.integer    :account_status,        null: false, default: 0

      ## Omniauthable
      t.string     :provider,              null: false, default: ''
      t.string     :uid,                   null: false, default: ''

      ## Recoverable
      t.string     :reset_password_token
      t.datetime   :reset_password_sent_at

      ## Rememberable
      t.datetime   :remember_created_at

      ## Trackable
      t.integer    :sign_in_count,           null: false, default: 0
      t.datetime   :current_sign_in_at
      t.datetime   :last_sign_in_at
      t.string     :current_sign_in_ip
      t.string     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.timestamps                           null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :users, :display_name,         unique: true
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
