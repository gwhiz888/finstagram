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

# post / login route
#    if user && user.authenticate(password)
          #session[:user_id] = user.id 

