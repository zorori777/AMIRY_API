class CreateCircleImages < ActiveRecord::Migration[5.1]
  def change
    create_table :circle_images do |t|
      t.references :circle, null: false, foreign_key: true
      t.string     :name,   null: false, default: ''
      t.timestamps          null: false
    end
  end
end
