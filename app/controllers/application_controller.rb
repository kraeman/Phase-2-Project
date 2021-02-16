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
      def current_user(hash)
        id = hash[:user_id]
        return User.find(id)
      end

      def logged_in?(hash)
        if current_user(hash)
            true
        else
            false
        end
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


      def redirect_if_not_logged_in(hash)
        if !logged_in?(hash)
          redirect "/login" if !logged_in?
        end
      end

      # def not_the_owner?(item)
      #   if !belongs_to_current_user_as_giver && !belongs_to_current_user_as_receiver
      #     redirect '/cakes' 
      #   end
      # end

    end
  end
  