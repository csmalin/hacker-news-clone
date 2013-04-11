class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :email, :password_hash, :name
      u.timestamps
    end
  end
end
