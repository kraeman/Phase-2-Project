class UsersController < ApplicationController

    get '/users/new' do
        erb :'/users/new'
    end

    post '/users' do
        date_string = params["user"]["birth_date"]
        begin
            date = date_string.to_date
        rescue
            erb :'/new_user_error'
        else
            user = User.create(name: params["user"]["name"],username: params["user"]["username"],password: params["user"]["password"],birth_date: date)
                if (params["user"]["name"] != "" && params["user"]["birth_date"] != "" && params["user"]["username"] != "" && params["user"]["password"] != "") && (params["user"]["name"].to_i.is_a? Integer)
                    user.age = age(user.birth_date)
                    user.save
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
    end

    get '/users/:id' do
        begin
            User.find(params["id"])
        rescue
            erb :'/not_found'
        else
            if !logged_in?(session)
                redirect '/'
            else
                user = User.find(params["id"])
                user.age = age(user.birth_date)
                user.save
                if user == current_user(session)
                    @user = user
                    erb :'/users/show'
                else
                    erb :'error'
                end
            end
        end
    end

    get '/users/:id/edit' do
        begin
            User.find(params["id"])
        rescue
            erb :'/not_found'
        else
            if !logged_in?(session)
                redirect '/'
            else
                user = User.find(params["id"])
                if user == current_user(session)
                    @user = user
                    erb :'/users/edit'
                else
                    erb :'error'
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
            erb :'/edit_user_error'
        else
            
                if params["user"]["name"] != "" && params["user"]["birth_date"] != ""
                    user.birth_date = date
                    user.save
                    user.update(name: params["user"]["name"], birth_date: params["user"]["birth_date"])
                    user.age = age(user.birth_date)
                    user.save
                    redirect "users/#{user.id}"
                else
                    @user = user
                    erb :"/edit_user_error"
                end
        end
    end
end