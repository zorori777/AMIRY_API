class CreateArticleComments < ActiveRecord::Migration[5.1]
  def change
    create_table :article_comments, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.integer    :user_id,    null: false
      t.integer    :article_id, null: false
      t.string     :content,    null: false, default: ''
      t.timestamps              null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :article_comments, :user_id

  end
end
