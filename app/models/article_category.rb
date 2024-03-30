class ArticleCategory < ApplicationRecord

  # connection with the article model and the category model is build by this
  # create and association between the article and category
  belongs_to :article

  # only singular term should be used
  # or will throw an error of initialized constant
  belongs_to :category

end
