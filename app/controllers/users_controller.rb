class UserController < ApplicationController

    get '/users/new' do
        @people = Person.all
        erb :'/cakes/new'
    end

    get '/users/:id/edit' do
        @user = User.find(params["id"])
        #why array rather thaan boolean?
        @array = [true, false]
        erb :'/users/edit'
    end

    get '/users/account' do

        @user_id = session[:user_id]
        @user = User.find(@user_id)
      
        erb :'/users/account'
    end

    get '/users/signup' do
    
        erb :'/users/signup'
    end

    get '/users/:id' do
       
        @user = User.find(params["id"])
        erb :'/users/account'
    end

    post '/users/index' do
        @user = User.create(params["user"])
 
        
        @user.save
    
        redirect to "/users/#{@user.id}"
    end

    patch '/users/:id' do
        @user = User.find(params["id"])

        @user.update(name: params["user"]["name"], age: params["user"]["age"], birth_date: params["user"]["birth_date"])
    

        @user.save

        redirect "users/#{@user.id}"
    end
end