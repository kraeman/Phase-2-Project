    
class SessionsController < ApplicationController
    get "/login" do
        redirect "/cakes" if logged_in?
        erb :"/sessions/login.html"
    end

    post '/login' do
        user = User.find_by(username: params[:username], password: params[:password])
        if user && user.authenticate(params["user"]["password"])
            session[:user_id] = user.id
            redirect "/users/:id"
        else
            erb :login_error
        end
    end

    # post '/signup' do
    #     unless User.find_by(username: params[:user][:username])
    #     @user = User.create(username: params[:user][:username], password: params[:user][:password],name: params[:user][:name], birth_date: params[:user][:birth_date])
    #     if @user
    #         #WHERE I LEFT OFFFFF
    #         @user.age = age(@user.birth_date)
    #         session[:user_id] = @user.id
    #         redirect "/users/account"
    #     end
    #     end
        
    #     erb :signup_error
    # end

    get '/logout' do
        session.clear
        redirect '/'
    end
end