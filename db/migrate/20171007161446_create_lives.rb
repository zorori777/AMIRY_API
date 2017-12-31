class CreateLives < ActiveRecord::Migration[5.1]
  def change
    create_table :lives, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.integer    :circle_id,                          null: false
      t.string     :name,                               null: false, default: ''
      t.text       :description,                        null: false
      t.integer    :max_capacity,       unsigned: true, null: false, default: 0
      t.integer    :reservations_count, unsigned: true, null: false, default: 0
      t.datetime   :hold_at,                            null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps                                      null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :lives, :circle_id
    add_index :lives, :hold_at
  end
end
