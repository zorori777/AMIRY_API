class CreateArticleFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :article_files do |t|
      t.integer    :user_id,    unsigned: true, null: false
      t.integer    :article_id, unsigned: true, null: false
      t.string     :name,                       null: false, default: ''
      t.timestamps                              null: false
    end
  end
end
