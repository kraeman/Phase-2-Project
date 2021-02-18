class ApplicationController < Sinatra::Base
    configure do
      set :public_folder, 'public'
      enable :sessions
      set :session_secret, ENV["SECRET"]
    end
    set :views, proc { File.join(root, '../views/') }
    register Sinatra::Twitter::Bootstrap::Assets

    get '/' do
      erb :"welcome"
    end

    get '/login' do
      erb :"sessions/login"
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
  