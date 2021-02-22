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
      redirect_if_not_logged_in
      current_user
      erb :"/errors/error"
    end

    get '/errors/not_found' do
      redirect_if_not_logged_in
      current_user
      erb :"/errors/not_found"
    end
    
    get '/errors/login_error' do
      redirect_if_logged_in
      erb :"/errors/login_error"
    end 

    


    helpers do
      def redirect_if_not_logged_in
        redirect "/" if !logged_in?
      end

      def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      end
      

      def logged_in?
        !!current_user
      end

      def redirect_if_logged_in
        if logged_in?
          redirect "/users/#{current_user.id}"
        end
      end
      
    end
  end
  