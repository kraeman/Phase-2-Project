class UsersController < ApplicationController

    get '/users/new' do
        redirect_if_logged_in
        erb :'/users/new'
    end

    post '/users' do
        redirect_if_logged_in
        date_string = params["user"]["birth_date"]
        begin
            date = date_string.to_date
        rescue
            redirect "/errors/new_user_error"
        else
            user = User.create(name: params["user"]["name"],username: params["user"]["username"],password: params["user"]["password"],birth_date: date)
                if user.valid? && params["user"]["password"] != ""
                    user.age = age(user.birth_date)
                    user.save
                    session["user_id"] = user.id
                    redirect "/users/#{user.id}"
                else
                    redirect "/errors/signup_error"
                end
        end
    end

    get '/users/:id' do
        redirect_if_not_logged_in
        user = User.find_by(id: params["id"])
        if user && user.id == current_user.id
                    current_user
                    erb :'/users/show'
        elsif user.id!= current_user.id
            redirect "/errors/error"
        else
            redirect "/errors/not_found"
        end
    end

    get '/users/:id/edit' do
        redirect_if_not_logged_in
        user = User.find_by(id: params["id"])
        if user
                if user.id == current_user.id
                    current_user
                    erb :'/users/edit'
                else
                    redirect "/errors/error"
                end
        else
                redirect "/errors/not_found"
        end
    end

    get '/users/signup' do
        redirect_if_logged_in
        erb :'/users/new'
    end

    get '/errors/edit_user_error' do
        redirect_if_not_logged_in
            @current_user = current_user
            erb :"/errors/edit_user_error"
    end  

    get '/errors/new_user_error' do
        redirect_if_logged_in
        erb :"/errors/new_user_error"
    end  

    get '/errors/signup_error' do
        redirect_if_logged_in
        erb :"/errors/signup_error"
    end  

    patch '/users/:id' do
        redirect_if_not_logged_in
        if current_user.id == params["id"].to_i
            user_save = User.find(params["id"])
            user = User.find(params["id"])
            date_string = params["user"]["birth_date"]
            begin
                date = date_string.to_date
            rescue
                redirect "/errors/edit_user_error"
            else
                    if user
                        user.birth_date = date
                        user.update(params["user"])
                        user.age = age(date)
                        if params["user"]["password"] != ""
                            user.update(password: params["user"]["password"])
                        end
                        user.save
                        if !user.valid?
                            user = user_save
                            user.save
                            redirect "/errors/edit_user_error"
                        end
                        redirect "users/#{user.id}"
                    end
            end
        else
            redirect "/errors/error"
        end
    end

    delete '/users/:id/delete' do
       redirect_if_not_logged_in
       if current_user.id == params["id"].to_i
            User.delete(params["id"])
            redirect "/logout"
       end
    end

    #is this right way to make something private?
    # private
        def age(dob)
            now = Time.now
            years = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
            return years
        end
end