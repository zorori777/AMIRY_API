class CreateLectures < ActiveRecord::Migration[5.1]
  def change
    create_table :lectures, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.references :user,        null: false, foreign_key: true
      t.text       :description, null: false
      t.string     :address,     null: false, default: ''
      t.datetime   :hold_at,     null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps               null: false, default: -> { 'CURRENT_TIMESTAMP' }  
    end

    add_index :lectures, :hold_at
  end
end
