class CreateUserParts < ActiveRecord::Migration[5.1]
  def change
    create_table :user_parts, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.references :user, null: false, foreign_key: true
      t.references :part, null: false, foreign_key: true
      t.timestamps        null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
