class UsersController < ApplicationController

    get '/users/new' do
        erb :'/users/new'
    end

    post '/users' do
        if params["user"]["name"] != "" && params["user"]["birth_date"] != "" && params["user"]["username"] != "" && params["user"]["password"] != ""
            user = User.create(params["user"])
            if user.valid?
                session["user_id"] = user.id
                redirect "/users/#{user.id}"
            else
                redirect "/users/new"
            end
        else
            erb :"/new_user_error"
        end
    end

    get '/users/:id' do
        user = User.find(params["id"])
        if user == current_user(session)
            @user = user
            erb :'/users/show'
        else
            erb :'error'
        end
    end

    get '/users/:id/edit' do
        user = User.find(params["id"])
        if user == current_user(session)
            @user = user
            erb :'/users/edit'
        else
            erb :'error'
        end
    end

    get '/users/signup' do
        erb :'/users/new'
    end

    


    patch '/users/:id' do
        user = User.find(params["id"])
        if params["user"]["name"] != "" && params["user"]["birth_date"] != ""

            user.update(name: params["user"]["name"], age: params["user"]["age"], birth_date: params["user"]["birth_date"])
        

            # user.save

            redirect "users/#{user.id}"
        else
            @user = user
            erb :"/edit_user_error"
        end
    end
end