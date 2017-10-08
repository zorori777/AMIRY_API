class CreateCircleImages < ActiveRecord::Migration[5.1]
  def change
    create_table :circle_images do |t|
      t.references :circle,                null: false, foreign_key: true
      t.string     :name,                  null: false, default: ''
      t.integer    :type,   unsigned:true, null: false, default: 0
      t.timestamps                         null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
