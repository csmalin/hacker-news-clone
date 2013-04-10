class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |cv|
      cv.references :user, :comment
    end
  end
end
