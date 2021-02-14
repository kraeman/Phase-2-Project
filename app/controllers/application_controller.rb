class ApplicationController < Sinatra::Base
    configure do
      enable :sessions
      set :session_secret, ENV["SECRET"]
    end
    set :views, proc { File.join(root, '../views/') }
    register Sinatra::Twitter::Bootstrap::Assets

  
    # def self.current_user(hash)
    #   @id = hash[:user_id]
    #   return User.find(@id)
    # end

    # def self.is_logged_in?(hash)
    #   @id = hash[:user_id]
    #   @user = User.find(@id)
    #   if @user
    #       true
    #   else
    #       false
    #   end
    # end

    get '/' do
      erb :"application/index"
    end

    get '/login' do
      erb :'sessions/login'
    end

    
  

    post '/sessions' do
    
      @user = User.find_by(username: params[:username], password: params[:password])
      
      if @user
        session[:user_id] = @user.id
        redirect "/users/account"
      end
      erb :login_error
    end

    post '/signup' do
      unless User.find_by(username: params[:user][:username])
        @user = User.create(username: params[:user][:username], password: params[:user][:password],name: params[:user][:name], birth_date: params[:user][:birth_date])
        if @user
          #WHERE I LEFT OFFFFF
          @user.age = age(@user.birth_date)
          session[:user_id] = @user.id
          redirect "/users/account"
        end
      end
      
      erb :signup_error
    end

    get '/logout' do
      session.clear
      redirect '/'
    end
  

    def age(dob)
      now = Time.now.utc
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end
      
    def belongs_to_current_user_as_receiver?(item, hash)
   
      @id = hash[:user_id]
      @user = User.find(@id)
        if item.receiver_id == @id
            true
        else
            false
        end
    end

    def belongs_to_current_user_as_giver?(item, hash)
      @id = hash[:user_id]
      @user = User.find(@id)
        if item.giver_id == @id
            true
        else
            false
        end
    end
  end
  