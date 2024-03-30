class AddDescriptionToArticles < ActiveRecord::Migration[6.1]
  # Alter table to add the description column in the article table with type text
  def change
    add_column :articles, :description, :text
  end
end
