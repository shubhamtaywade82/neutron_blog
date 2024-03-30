class AddPasswordDigestToUsers < ActiveRecord::Migration[6.1]
  def change
    # adds password column to tht users table (password_digest
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    add_column :users, :password_digest, :string
  end
end
