class ApplicationController < Sinatra::Base
    configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
      set :session_secret, ENV["SECRET"]
      register Sinatra::Flash
    end

    get '/' do
      redirect_if_logged_in
      erb :"welcome"
    end

    get '/errors/error' do
      erb :"/errors/error"
    end

    get '/errors/not_found' do
      erb :"/errors/not_found"
    end
    
    get '/errors/login_error' do
      erb :"/errors/login_error"
    end 

    


    helpers do
      def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      end
      

      def logged_in?
        !!current_user
      end

      def age(dob)
        now = Time.now
        years = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
        return years
      end

      def redirect_if_logged_in
        if logged_in?
          redirect "/users/#{current_user.id}"
        end
      end
        
      def belongs_to_current_user?(item, hash)
          id = hash[:user_id]
          if item.owner_id == id
              true
          else
              false
          end
      end
      
    end
  end
  