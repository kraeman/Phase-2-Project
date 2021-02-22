class SessionsController < ApplicationController
    get "/login" do
        redirect_if_logged_in
        erb :"/sessions/login"
    end

    post '/login' do
        redirect_if_logged_in
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            redirect "/errors/login_error"
        end
    end


    get '/logout' do
        session.clear
        erb :'/welcome'
    end
end