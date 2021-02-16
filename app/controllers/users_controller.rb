class UsersController < ApplicationController

    get '/users/new' do
        erb :'/users/new'
    end

    post '/users' do
        user = User.create(params["user"])
        if user.valid?
            session["user_id"] = user.id
            redirect '/users/:id'
        else
            #flash
            redirect "/users/new"
        end
    end

    get '/users/:id' do
        @user = User.find(params["id"])
        if @user == current_user(session)
            erb :'/users/show'
        else
            #error
        end
    end

    get '/users/:id/edit' do
        @user = User.find(params["id"])
        #why array rather than boolean?
        @array = [true, false]
        erb :'/users/edit'
    end

    get '/users/signup' do
        erb :'/users/new'
    end

    


    patch '/users/:id' do
        user = User.find(params["id"])

        user.update(name: params["user"]["name"], age: params["user"]["age"], birth_date: params["user"]["birth_date"])
    

        user.save

        redirect "users/#{user.id}"
    end
end