class CreateCircles < ActiveRecord::Migration[5.1]
  def change
    create_table :circles, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.references :university,                    null: false, foreign_key: true 
      t.string     :name,                          null: false, default: ''
      t.string     :description,                   null: false, default: ''
      t.integer    :members_count, unsigned: true, null: false, default: 0
      t.integer    :bands_count,   unsigned: true, null: false, default: 0
      t.timestamps                                 null: false
    end

    add_index :circles, [:name, :university_id], unique: true
  end
end
