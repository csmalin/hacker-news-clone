class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |p|
      p.string :title, :link
      p.text :body
      p.references :user
      p.timestamps
    end
  end
end
