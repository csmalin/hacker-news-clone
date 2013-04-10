class Comment < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :post
  has_many :comment_votes
end
