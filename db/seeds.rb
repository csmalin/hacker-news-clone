require 'faker'

100.times do |u|
  User.create(:email => Faker::Internet.email,
              :name => Faker::Internet.user_name)
end

100.times do |p|
  Post.create(:title => Faker::Company.catch_phrase,
              :link => [Faker::Internet.url, ""].sample,
              :user => User.all.sample)
end

100.times do |c|
  Comment.create(:body => Faker::Company.bs,
                 :user => User.all.sample,
                 :post => Post.all.sample)
end

200.times do |pvotes|
  User.all.sample.post_votes << Post.all.sample.post_votes.create
end

200.times do |cvotes|
  User.all.sample.comment_votes << Comment.all.sample.comment_votes.create
end
