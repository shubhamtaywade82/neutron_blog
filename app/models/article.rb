class Article < ApplicationRecord

  # this defines that the article belongs to the user with user_id
  # first Symbol here is the current user, the class name of the model, and the key to which the user is referenced
  # singular name of the virtual reference of the object user
  belongs_to :user

  # Specifies the one - to  - many assiscation betwenn this mmodel and the
  # metiond model
  has_many :article_categories

  # specifies the assicuation throufht which table model query
  # many to many relation is built using method between thhe models article and category
  has_many :categories, through: :article_categories
  has_many :article_tags
  has_many :tags, through: :article_tags
  # validates the attribute before hitting the database
  # generates predefined errors if the validation not met by the attributes
  validates :title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, presence: true, length: { minimum: 3, maximum: 300 }
  # adding the validation for user_id (a user must be associated with the articles)
  # before saving into the database
  validates :user_id, presence: true


  # Check is the {User} can edit the article or not
  #
  # @param [User] user
  #
  # @return [Boolean]
  def can_be_edited_by?(user)
    user.admin? || user_id == user.id
  end

end
