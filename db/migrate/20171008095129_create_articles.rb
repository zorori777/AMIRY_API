class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.integer    :user_id,       null: false
      t.string     :title,         null: false, default: ''
      t.text       :content,       null: false
      t.integer    :updated_times, null: false, default: 0
      t.timestamps                 null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :articles, :user_id
    add_index :articles, :created_at
  end
end
