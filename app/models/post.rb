require 'faker'

class Post < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_many :comments
  has_many :post_votes

  before_create :add_link

  def add_link
    if self.link == ""
      self.link = "/posts/#{Post.all.length + 1}"
      self.body = Faker::Lorem.sentence(10)
    end
  end
end
