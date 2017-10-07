class CreateBands < ActiveRecord::Migration[5.1]
  def change
    create_table :bands, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.references :university,                  null: false, foreign_key: true
      t.string     :name,                        null: false, default: ''
      t.string     :concept,                     null: false, default: ''
      t.text       :description,                 null: false
      t.integer    :people_num,  unsigned: true, null: false, default: 0
      t.integer    :type,        unsigned: true, null: false, default: 0, limit: 1
      t.datetime   :united_at,                   null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps                               null: false
    end

    add_index :bands, [:university_id, :name], unique: true
  end
end
