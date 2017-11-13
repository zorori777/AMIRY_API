class CreateMatchings < ActiveRecord::Migration[5.1]
  def change
    create_table :matchings do |t|
      t.integer    :like_id,    null: false
      t.integer    :user_id,    null: false
      t.integer    :acceptance, null: false, limit: 1
      t.timestamps              null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :matchings, [:like_id, :user_id], unique: true
  end
end
