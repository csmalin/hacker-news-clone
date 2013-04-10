class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |c|
      c.text :body
      c.references :user, :post
    end
  end
end
