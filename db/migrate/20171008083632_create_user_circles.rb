class CreateUserCircles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_circles, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.integer    :user_id,   null: false
      t.integer    :circle_id, null: false
      t.timestamps             null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
