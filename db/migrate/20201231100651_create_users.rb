class CreateUsers < ActiveRecord::Migration[6.1]
  # migration for creating the users table
  def change
    create_table :users do |t|
      t.string :username
      t.string :email

      t.timestamps
    end
  end
end
