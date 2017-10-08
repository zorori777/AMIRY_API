class CreateMatchings < ActiveRecord::Migration[5.1]
  def change
    create_table :matchings do |t|
      t.references :like,       null: false, foreign_key: true
      t.references :user,       null: false, foreign_key: true
      t.integer    :acceptance, null: false, limit: 1
      t.timestamps              null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
