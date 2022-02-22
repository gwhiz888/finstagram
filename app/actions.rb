# Index page
# get '/' do
     #File.read(File.join('app/views', 'index.html'))
#end

helpers do 
     def current_user
          User.find_by(id: session[:user_id])
     end
end

get '/' do

     @finstagram_posts = FinstagramPost.order(created_at: :desc)
     
     erb(:index)
end

get '/signup' do #if a user navigates to the path "/signup", 

     @user = User.new # setup empty @user object

     erb(:signup) # render "app/views/signup.erb"

end

get '/login' do #if a user navigates to the path "/login",
   
     erb(:login) # render "app/views/login.erb
     
end

get '/logout' do
     session[:user_id] = nil 
     "Logout successful!"
end

get '/finstagram_posts/new' do
     @finstagram_post = FinstagramPost.new
     erb(:"finstagram_posts/new")

end

get '/finstagram_posts/:id' do
     @finstagram_post = FinstagramPost.find(params[:id])    # find the finstagram post with the ID from the URL
     erb(:"finstagram_posts/show")                          # render app/views/finstagram_posts/show.erb
end

post '/signup' do  
     
     # grab user input values from params
     email          = params[:email]
     avatar_url     = params[:avatar_url]
     username       = params[:username]
     password       = params[:password]


     # instantiate and save a User 
     @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })
          
     # if user validations pass and user is saved
     if @user.save
          redirect to('/login')
        
     else
     
          erb(:signup)
       
    end
end
post '/login' do # when we submit a form with an action of /login
     username = params[:username]
     password = params[:password]

     # 1. find user by username 
     @user = User.find_by(username: username)


          # check if that user's password matches the password input 
          #3. if the passwords match 
          if @user && @user.authenticate(password)
               session[:user_id] = @user.id
               redirect to('/')

          else
               @error_message = "Login failed."
               erb(:login)
          end

end

post '/finstagram_posts' do
     photo_url = params[:photo_url]

     #instantiate new FinstagramPost
     @finstagram_post = FinstagramPost.new({ photo_url: photo_url, user_id: current_user.id})

     # if @post validates, save 
     if @finstagram_post.save
          redirect(to('/'))
     
     else

     # if it doesn't validate, print error messages
     erb(:"finstagram_posts/new")

     end

end

post '/comments' do

     # point values from params to variables
     text = params[:text]
     finstagram_post_id = params[:finstagram_post_id]

     # instatantiate a comment with thsoe values & assign the comment to the 'current_user'
     comment = Comment.new({ text: text, finstagram_post_id: finstagram_post_id, user_id: current_user.id })

     # save the comment 
     comment.save

     # 'redirect' back to where we came from 
     redirect(back)

end

post '/likes' do
     finstagram_post_id = params[:finstagram_post_id]

     like = Like.new({ finstagram_post_id: finstagram_post_id, user_id: current_user.id })
     like.save

     redirect(back)
end

delete '/likes/:id' do
     like = Like.find(params[:id])
     like.destroy
     redirect(back)
end

# post / login route
#    if user && user.authenticate(password)
          #session[:user_id] = user.id 

