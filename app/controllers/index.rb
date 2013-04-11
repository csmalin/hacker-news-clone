get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end  
  all_posts = Post.all
  posts_by_vote = []
  all_posts.each do |p|
    posts_by_vote << { :id => p.id,
                       :votes => p.post_votes.length }
  end

  posts_hashes_sorted = posts_by_vote.sort do |a, b|
    b[:votes] <=> a[:votes]
  end

  @posts = posts_hashes_sorted.map do |hash|
    Post.find(hash[:id])
  end

  # @posts = Post.last(30).reverse
  erb :index
end

get '/logout' do
  session.destroy
  redirect '/'
end

post '/signup' do
  user = User.create(params[:user])
  session[:user_id] = user.id
  redirect '/'
end

get '/login' do
  erb :login, :layout => false
end

post '/login' do
  @user = User.authenticate(params[:user][:name],params[:user][:password])
  # raise user.inspect
  session[:user_id] = @user.id

  redirect '/'
end

get '/submit' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end  
  if signed_in?
    erb :create_post
  else
    erb :login_signup, :layout => false
  end
end

post '/new_post' do
  post = Post.create(:title => params[:post][":title"],
                     :link => params[:post][":link"],
                     :body => params[:post][":body"],
                     :user_id => session[:user_id])
  redirect "/posts/#{post.id}"
end

get '/posts/:id' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
  @post = Post.find(params[:id])
  erb :show_post
end

post '/posts/:id/upvote' do
  if session[:user_id]
    if Post.find(params[:id]).post_votes.find_by_user_id(session[:user_id])
      redirect "/posts/#{params[:id]}"
    else
      PostVote.create(:post_id => params[:id], :user_id => session[:user_id])
      redirect("/posts/#{params[:id]}")
    end
  end
end

post '/upvote/:id' do
  @post = Post.find(params[:id])
end

get '/users/:id' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
  @user = User.find(params[:id])

  erb :user_profile
end

get '/comments' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
  @comments = Comment.last(30).reverse

  erb :show_comments
end

post '/posts/:post_id/add_comment' do
  if session[:user_id]
    comment = Comment.create(:body => params[:text],
                   :post_id => params[:post_id],
                   :user_id => session[:user_id])
  end
  redirect "/posts/#{params[:post_id]}"
end

get '/new' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
  @posts = Post.last(30).reverse

  erb :index
end


