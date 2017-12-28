class CreateLiveImages < ActiveRecord::Migration[5.1]
  def change
    create_table :live_images, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
      t.integer    :live_id, null: false
      t.string     :name,    null: false, default: ''
      t.timestamps           null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :live_images, %i(live_id name), unique: true
  end
end
