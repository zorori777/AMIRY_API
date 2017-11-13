class CreateBandLives < ActiveRecord::Migration[5.1]
  def change
    create_table :band_lives, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.integer    :band_id, null: false
      t.integer    :live_id, null: false
      t.timestamps           null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
