class CreateCircleImages < ActiveRecord::Migration[5.1]
  def change
    create_table :circle_images do |t|
      t.integer    :circle_id,                 null: false
      t.string     :name,                      null: false, default: ''
      t.integer    :type,      unsigned: true, null: false, default: 0
      t.timestamps                             null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :circle_images, [:circle_id, :name], unique: true
  end
end
