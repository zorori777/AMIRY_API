class CreateCircles < ActiveRecord::Migration[5.1]
  def change
    create_table :circles, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.integer    :university_id,                 null: false
      t.string     :name,                          null: false, default: ''
      t.string     :description,                   null: false, default: ''
      t.integer    :members_count, unsigned: true, null: false, default: 0
      t.integer    :bands_count,   unsigned: true, null: false, default: 0
      t.timestamps                                 null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :circles, [:name, :university_id], unique: true
  end
end
