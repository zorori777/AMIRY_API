class CreateBandImages < ActiveRecord::Migration[5.1]
  def change
    create_table :band_images do |t|
      t.references :band, null: false, foreign_key: true
      t.string     :name, null: false, default: ''
      t.timestamps        null: false, default: -> { 'CURRENT_TIMESTAMP '}
    end
  end
end
