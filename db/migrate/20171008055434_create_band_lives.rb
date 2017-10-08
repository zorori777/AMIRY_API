class CreateBandLives < ActiveRecord::Migration[5.1]
  def change
    create_table :band_lives, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.references :band, null: false, foreign_key: true
      t.references :live, null: false, foreign_key: true
      t.timestamps        null: false
    end
  end
end
