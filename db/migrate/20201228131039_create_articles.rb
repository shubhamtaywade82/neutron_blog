class CreateArticles < ActiveRecord::Migration[6.1]

  # this contains the details regarding the contents of the table and its types

  # creates a new article table using the migration file
  def change
    create_table :articles do |t|
      t.string :title

      t.timestamps
    end
  end
end
