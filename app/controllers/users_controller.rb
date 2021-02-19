class UsersController < ApplicationController

    get '/users/new' do
        redirect_if_logged_in
        erb :'/users/new'
    end

    post '/users' do
        date_string = params["user"]["birth_date"]
        begin
            date = date_string.to_date
        rescue
            erb :'/errors/new_user_error'
        else
            user = User.create(name: params["user"]["name"],username: params["user"]["username"],password: params["user"]["password"],birth_date: date)
                if (params["user"]["name"] != "" && params["user"]["birth_date"] != "" && params["user"]["username"] != "" && params["user"]["password"] != "") && (params["user"]["name"].to_i.is_a? Integer)
                    user.age = age(user.birth_date)
                    user.save
                    if user.valid?
                        session["user_id"] = user.id
                        redirect "/users/#{user.id}"
                    else
                        erb :"/errors/signup_error"
                    end
                else
                    erb :"/errors/new_user_error"
                end
        end
    end

    get '/users/:id' do
        begin
            User.find(params["id"])
        rescue
            if logged_in?
                erb :'/errors/not_found'
            else
                redirect '/'
            end
        else
            if !logged_in?
                redirect '/'
            else
                user = User.find(params["id"])
                user.age = age(user.birth_date)
                user.save
                if user == current_user
                    @user = user
                    erb :'/users/show'
                else
                    @user = user
                    if logged_in?
                        erb :'/errors/error'
                    else
                        redirect '/'
                    end
                end
            end
        end
    end

    get '/users/:id/edit' do
        begin
            User.find(params["id"])
        rescue
            if logged_in?
                erb :'/errors/not_found'
            else
                redirect '/'
            end
        else
            if !logged_in?
                redirect '/'
            else
                user = User.find(params["id"])
                if user == current_user
                    @user = user
                    erb :'/users/edit'
                else
                    @user = user
                    if logged_in?
                        erb :'/errors/error'
                    else
                        redirect '/'
                    end
                end
            end
        end
    end

    get '/users/signup' do
        erb :'/users/new'
    end

    


    patch '/users/:id' do
        user = User.find(params["id"])
        date_string = params["user"]["birth_date"]
        begin
            date = date_string.to_date
        rescue
            @user = user
            erb :'/errors/edit_user_error'
        else
                if params["user"]["name"] != "" && params["user"]["birth_date"] != "" && params["user"]["username"] != ""
                    user.birth_date = date
                    user.save
                    user.update(name: params["user"]["name"], birth_date: params["user"]["birth_date"], username: params["user"]["username"])
                    if params["password"] != ""
                        user.update(password: params["user"]["password"])
                    end
                    user.age = age(user.birth_date)
                    user.save
                    redirect "users/#{user.id}"
                else
                    @user = user
                    erb :"/errors/edit_user_error"
                end
        end
    end

    delete '/users/:id/delete' do
        User.delete(params["id"])
        redirect "/logout"
    end
end