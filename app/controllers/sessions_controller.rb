class SessionsController < ApplicationController
    get "/login" do
        redirect "/cakes" if logged_in?
        erb :"/sessions/login"
    end

    post '/login' do
        user = User.find_by(username: params[:username], password: params[:password])
        if user
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            erb :'/errors/login_error'
        end
    end


    get '/logout' do
        session.clear
        redirect '/'
    end
end