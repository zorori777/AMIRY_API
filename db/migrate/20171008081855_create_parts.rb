class CreateParts < ActiveRecord::Migration[5.1]
  def change
    create_table :parts, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.integer    :name, null: false, default: 0
      t.timestamps        null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :parts, :name, unique: true
  end
end
