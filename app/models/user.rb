# Created the User resources model to access the users table data
class User < ApplicationRecord

  def gravatar_url
    gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
    uri = URI::HTTPS.build(host: 'secure.gravatar.com', path: "/avatar/#{gravatar_id}")
    uri.to_s
  end

  # this user model is created for the table  =  users with attributes Email and username
  # A user can create many articles (o or more articles )
  # this relation is specified by the has many articles
  # article model is plural to define many articles

  # article = Article.create(title: "Shubham Article", description: "created
  # using the the association", user: user)

  # creates the article with the foreign key as the primary key of the user i.e id

  # Specifies that a user can create or relate to many Articles
  # This helper of ApplicationRecord helps to associate this user to many articles

  # articles of that particular user will be deleted if we delete the user
  has_many :articles, dependent: :destroy

  # this helper runs the block before saving the data the database
  # this block converts email to downcase each time before saving it to the database
  before_save { self.email = email.downcase }
  # the validates method is available in this class due to the inheritance of
  # the ApplicationRecord which inherits the ActiveRecords, this method allows
  # us to validate a attribute of the model using various helpers provided
  # uniqueness, format, length, presence, inclusion, acceptance etc

  # this method validates the username if any rules  set using the helper if
  # if any rule is violated this generates respective error and is  stored in
  # the user instance

  # this is checked before hitting the database if the values are not valid
  # here the rule set using helpers are - username must be present(mandatory)
  # no redundant usernames (ignoring the case sensitivity)
  # minimum 2 characters and max 25 character
  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 2, maximum: 25 }

  # valid emails eg.
  #   bob@email.com
  #   shubham@gmail.com
  #   as@gm.co
  #   prajwal@yahoo.com
  #   khushal.patil@gmail.com

  # @return [Regex] valid email
  VALID_EMAIL_REGEX = /([A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4})/i.freeze

  # the rules set for email are same as the username but
  # email follows a proper pattern i.e username@example.com
  # for this we use the format: {with: REGEX}  to validate format for email
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: VALID_EMAIL_REGEX },
    length: { maximum: 105 }

  # To check whether the resource attributes are valid or not with out trying
  # to hit the persistent database
  # we can user valid? or invalid? methods to check it

  # user.valid? => true or false
  # user.invalid? => false or true

  # ActiveModel::SecurePassword::ClassMethods
  # ActiveModel::Validations - module for validations methods
  # ActiveRecord::ApplicationRecord has a method called as the has_secure_password
  # has_secure_password(attribute = :password, validation: true)
  # default attribute is password and the validations attribute is set to true by default
  # the predefined validations are
  #  * password must be present
  #  * length must be less than 72bytes
  #  * confirmation of password from confirmation_digest attribute
  # if default validation for the password is not need then set the (validations: false)
  # has_secure_password :recovery_password, validations: true
  has_secure_password
  # the password entered is converted to a hash that is " salts + password_hash "
  # before adding it to the database
  # the salts are always different for each entry
  # ex: entry one
  # "password" => ["password_digest", "$2a$12$dMLLeERhpVrbaeGKk2EJp.vvlyig2WHn84fVE2LzH/5Z8IedftV9u"]
  # ex: entry two
  # "password" =>["password_digest", "$2a$12$.uHsl9JSiy0F5goZOYbwIubDtxKIqz77NUQr6ld.S0ouHNq6WgEa."]
  # salts = "$2a$12$"
  # hash = "dMLLeERhpVrbaeGKk2EJp.vvlyig2WHn84fVE2LzH/5Z8IedftV9u"

end
