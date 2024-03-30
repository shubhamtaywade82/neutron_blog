class AddAdminToUsers < ActiveRecord::Migration[6.1]

  # Alter table to add the admin column to the users table
  #
  # @return [void]
  def change
    # add a colum to the users table to identify the admin
    add_column :users, :admin, :boolean, default: false
  end

end
