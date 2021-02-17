class UsersController < ApplicationController

    get '/users/new' do
        erb :'/users/new'
    end

    post '/users' do
      
        user = User.create(params["user"])
        if user.birth_date.is_a? Date
            if (params["user"]["name"] != "" && params["user"]["birth_date"] != "" && params["user"]["username"] != "" && params["user"]["password"] != "") && (params["user"]["name"].to_i.is_a? Integer)
                # user = User.create(params["user"])
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
        else
            User.all.pop
            erb :"/new_user_error"
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
        if user.birth_date.is_a? Date
            # user = User.find(params["id"])
            if params["user"]["name"] != "" && params["user"]["birth_date"] != ""
                # user = User.find(params["id"])
                user.update(name: params["user"]["name"], birth_date: params["user"]["birth_date"])
                user.age = age(user.birth_date)
                user.save
                redirect "users/#{user.id}"
            else
                @user = user
                erb :"/edit_user_error"
            end
        else
            @user = User.find(params["id"])
            erb :"/edit_user_error"
        end
    end
end