class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # repent, password-storer!
      t.string :password, :null => false
      t.string :session_token, :null => false
      t.string :user_name, :null => false

      t.timestamps
    end

    add_index :users, :session_token, :unique => true
  end
end
