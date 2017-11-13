class CreateBandImages < ActiveRecord::Migration[5.1]
  def change
    create_table :band_images do |t|
      t.integer    :band_id, null: false
      t.string     :name,    null: false, default: ''
      t.timestamps           null: false, default: -> { 'CURRENT_TIMESTAMP '}
    end

    add_index :band_images, [:band_id, :name], unique: true
  end
end
