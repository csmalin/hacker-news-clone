get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end  
  @posts = Post.last(30).reverse
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
  user = User.authenticate(params[:user][:name],params[:user][:password])
  # raise user.inspect
  session[:user_id] = user.id
  redirect '/'
end

get '/submit' do
  if signed_in?
    erb :create_post
  else
    erb :login_signup, :layout => false
  end
end

post '/new_post' do
  post = Post.create(params,
                     :user_id => session[:user_id])
  redirect '/posts/:post.id'
end

get '/posts/:id' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end  
  @post = Post.find(params[:id])
  erb :show_post
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
