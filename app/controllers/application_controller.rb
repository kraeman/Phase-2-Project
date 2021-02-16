class ApplicationController < Sinatra::Base
    configure do
      set :public_folder, 'public'
      enable :sessions
      set :session_secret, ENV["SECRET"]
    end
    set :views, proc { File.join(root, '../views/') }
    register Sinatra::Twitter::Bootstrap::Assets

    get '/' do
      erb :"welcome.erb"
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
        user = current_user(hash)
        if user
            true
        else
            false
        end
      end

      # def age(dob)
      #   now = Time.now.utc
      #   now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
      # end
        
      def belongs_to_current_user_as_receiver?(item, hash)
          id = hash[:user_id]
          if item.receiver_id == id
              true
          else
              false
          end
      end

      def belongs_to_current_user_as_giver?(item, hash)
        id = hash[:user_id]
          if item.giver_id == id
              true
          else
              false
          end
      end

      def redirect_if_not_logged_in
        if !logged_in?
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
  