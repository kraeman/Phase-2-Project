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
            redirect "/errors/new_user_error"
        else
            user = User.create(name: params["user"]["name"],username: params["user"]["username"],password: params["user"]["password"],birth_date: date)
                if (params["user"]["name"] != "" && params["user"]["birth_date"] != "" && params["user"]["username"] != "" && params["user"]["password"] != "") && (params["user"]["name"].to_i.is_a? Integer)
                    user.age = age(user.birth_date)
                    user.save
                    if user.valid?
                        session["user_id"] = user.id
                        redirect "/users/#{user.id}"
                    else
                        redirect "/errors/signup_error"
                    end
                else
                    redirect "/errors/new_user_error"
                end
        end
    end

    get '/users/:id' do
        user = User.find_by(id: params["id"])
        if user
            if logged_in?
                if user.id == current_user.id
                    @user = user
                    erb :'/users/show'
                else
                    redirect "/errors/error"
                end
            else
                redirect "/"
            end
        else
            if logged_in?
                redirect "/errors/not_found"
            else
                redirect '/'
            end
        end
    end

    get '/users/:id/edit' do
        user = User.find_by(id: params["id"])
        if user
            if logged_in?
                if user.id == current_user.id
                    @user = user
                    erb :'/users/edit'
                else
                    redirect "/errors/error"
                end
            else
                redirect "/"
            end
        else
            if logged_in?
                redirect "/errors/not_found"
            else
                redirect '/'
            end
        end
    end

    get '/users/signup' do
        erb :'/users/new'
    end

    get '/errors/edit_user_error' do
        if logged_in?
            @current_user = current_user
            erb :"/errors/edit_user_error"
        else
            redirect '/'
        end
    end  

    get '/errors/new_user_error' do
        erb :"/errors/new_user_error"
      end  

    get '/errors/signup_error' do
        erb :"/errors/signup_error"
    end  



    


    patch '/users/:id' do
        user = User.find(params["id"])
        date_string = params["user"]["birth_date"]
        begin
            date = date_string.to_date
        rescue
            redirect "/errors/edit_user_error"
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
                    redirect "/errors/edit_user_error"
                end
        end
    end

    delete '/users/:id/delete' do
        User.delete(params["id"])
        redirect "/logout"
    end
end