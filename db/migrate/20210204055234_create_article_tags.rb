class CreateArticleTags < ActiveRecord::Migration[6.1]
  def change
    create_table :article_tags do |t|
      t.belongs_to :article
      t.belongs_to :tag
    end
  end
end
