class CreateArticleComments < ActiveRecord::Migration[5.1]
  def change
    create_table :article_comments, option: 'ENGINE=InnoDB DEFAULT CHARSET=utf8;' do |t|
      t.references :user,    null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.string     :content, null: false, default: ''
      t.timestamps           null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
