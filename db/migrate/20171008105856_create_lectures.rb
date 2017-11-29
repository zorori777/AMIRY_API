class CreateLectures < ActiveRecord::Migration[5.1]
  def change
    create_table :lectures, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.integer    :user_id,     null: false
      t.string     :title,       null: false, default: ''
      t.text       :description, null: false
      t.string     :address,     null: false, default: ''
      t.datetime   :hold_at,     null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps               null: false, default: -> { 'CURRENT_TIMESTAMP' }  
    end

    add_index :lectures, :hold_at
    add_index :lectures, :user_id
    add_index :lectures, :title,  unique: true
  end
end
