class CreateUserBands < ActiveRecord::Migration[5.1]
  def change
    create_table :user_bands do |t|
      t.integer    :user_id, null: false
      t.integer    :band_id, null: false
      t.timestamps           null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
