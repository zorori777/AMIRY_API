class CreateLiveImages < ActiveRecord::Migration[5.1]
  def change
    create_table :live_images, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
      t.references :live, null: false, foreign_key: true
      t.string     :name, null: false, default: ''
      t.timestamps        null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
