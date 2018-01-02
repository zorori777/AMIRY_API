class CreateLectureFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :lecture_files do |t|
      t.integer    :user_id,    unsigned: true, null: false
      t.integer    :lecture_id, unsigned: true, null: false
      t.string     :name,                       null: false, default: ''
      t.timestamps                              null: false
    end

    add_index :lecture_files, :user_id
    add_index :lecture_files, :lecture_id
    add_index :lecture_files, :name,      unique: true
  end
end
