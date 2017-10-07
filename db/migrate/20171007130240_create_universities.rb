class CreateUniversities < ActiveRecord::Migration[5.1]
  def change
    create_table :universities, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.string     :name, null: false, default: ''
      t.timestamps        null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :universities, :name, unique: true
  end
end
