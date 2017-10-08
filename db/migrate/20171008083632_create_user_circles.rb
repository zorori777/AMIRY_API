class CreateUserCircles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_circles, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.references :user,   null: false, foreign_key: true
      t.references :circle, null: false, foreign_key: true
      t.timestamps          null: false
    end
  end
end
