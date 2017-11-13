class CreateUserLives < ActiveRecord::Migration[5.1]
  def change
    create_table :user_lives, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.integer    :user_id, null: false
      t.integer    :live_id, null: false
      t.timestamps           null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :user_lives, :user_id
    add_index :user_lives, :live_id
  end
end
