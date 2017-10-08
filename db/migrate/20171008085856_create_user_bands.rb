class CreateUserBands < ActiveRecord::Migration[5.1]
  def change
    create_table :user_bands do |t|
      t.references :user, null: false, foreign_key: true 
      t.references :band, null: false, foreign_key: true
      t.timestamps        null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
