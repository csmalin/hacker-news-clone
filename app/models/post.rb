class Post < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_many :comments
  has_many :post_votes
end
