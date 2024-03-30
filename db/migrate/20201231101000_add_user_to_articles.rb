class AddUserToArticles < ActiveRecord::Migration[6.1]
  # Run the +rails generate migration add_user_to_articles user:references+
  # this will create the following foreign key migration

  # we can the retrieve the user from this article object and articles of the particular user

  # how to use association to access related objects
  # eg article.user => #<User id: 1, username: "shubham_taywade", email: "shubham@gmail.com", created_at: "2020-12-31 08:42:38.609532000 +0000", updated_at: "2020-12-31 08:42:38.609532000 +0000">

  # 2.7.2 :055 > user.articles
  # Article Load (0.2ms)  SELECT "articles".* FROM "articles" WHERE "articles".# "user_id" = ?
  # /* loading for inspect */ LIMIT ?  [["user_id", 1], ["LIMIT", # 11]]
  # => <ActiveRecord::Associations::CollectionProxy [#<Article id: 8, title:
  # "Shubhams Article", created_at: "2020-12-31 10:11:37.134958000 +0000",
  # updated_at: "2020-12-31 10:11:37.134958000 +0000", description: "created
  # using the the association", user_id: 1>]>
  # 2.7.2 :057 > article.user
  # => #<User id: 1, username: "shubham_taywade", email: "shubham@gmail.com",
  # created_at: "2020-12-31 10:11:25.436043000 +0000", updated_at: "2020-12-31
  # 10:11:25.436043000 +0000">
  
  # Adds column foreign key to the articles table
  #
  # @return [void]
  def change
    add_reference :articles, :user, foreign_key: true
  end
end
