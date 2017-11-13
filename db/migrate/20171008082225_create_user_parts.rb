class CreateUserParts < ActiveRecord::Migration[5.1]
  def change
    create_table :user_parts, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.integer    :user_id, null: false
      t.integer    :part_id, null: false
      t.timestamps           null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
