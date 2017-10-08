class CreateUserLives < ActiveRecord::Migration[5.1]
  def change
    create_table :user_lives, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.references :user, null: false, foreign_key: true
      t.references :live, null: false, foreign_key: true
      t.timestamps        null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
