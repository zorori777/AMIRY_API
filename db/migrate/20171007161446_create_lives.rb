class CreateLives < ActiveRecord::Migration[5.1]
  def change
    create_table :lives, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.references :circle,                             null: false, foreign_key: true 
      t.string     :name,                               null: false, default: ''
      t.text       :description,                        null: false
      t.integer    :max_capacity,       unsigned: true, null: false, default: 0
      t.integer    :reservations_count, unsigned: true, null: false, default: 0
      t.integer    :type,               unsigned: true, null: false, default: 0,                         comment: 'サークルライブ: 1, サークルライブ以外: 2'
      t.datetime   :hold_at,                            null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps                                      null: false
    end

    add_index :lives, [:circle_id, :type]
    add_index :lives, :hold_at
  end
end
