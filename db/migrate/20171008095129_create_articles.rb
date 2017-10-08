class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.references :user,    null: false, foreign_key: true
      t.text       :content, null: false
      t.timestamps           null: false
    end

    add_index :articles, :created_at
  end
end
