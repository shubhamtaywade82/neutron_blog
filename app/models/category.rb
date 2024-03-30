class Category < ApplicationRecord

  # one to many association betweeen the Category and the article_categories  model
  has_many :article_categories

  # Many to many relation between the article and category model
  # through the article_categories table
  has_many :articles, through: :article_categories

end
