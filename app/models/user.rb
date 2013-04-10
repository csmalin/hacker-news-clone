class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :comment_votes
  has_many :post_votes

end
