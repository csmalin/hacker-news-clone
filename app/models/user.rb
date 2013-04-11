class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :comment_votes
  has_many :post_votes

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end


  def self.authenticate(name, password)
    @user = User.find_by_name(name)
    if @user
      return @user if (@user.password == password)
    end
    nil
  end
end
