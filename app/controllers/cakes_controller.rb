class CakesController < ApplicationController

    get '/cakes' do
        if !logged_in?
            redirect '/'
        else    
            @user = current_user
            @cakes_by_me = []
        
            Cake.all.each do |cake|
                if belongs_to_current_user?(cake, session)
                    @cakes_by_me << cake
                end
            end
            erb :'/cakes/index'
        end
    end

    get '/cakes/new' do
        if !logged_in?
            redirect '/'
        else
            @user = current_user
            erb :'/cakes/new'
        end
    end

    post '/cakes' do
        hours_string = params["cake"]["cook_time"]
        if hours_string.match?(/\A-?(?:\d+(?:\.\d*)?|\.\d+)\z/)
            hours = hours_string.to_f
            if params["cake"]["name"] != "" && params["cake"]["recipe"] != "" && params["cake"]["cook_time"] != ""
                cake = Cake.create(name: params["cake"]["name"],recipe: params["cake"]["recipe"],cook_time: hours)
                cake.user = current_user.id
                cake.save
                if cake.valid? 
                    redirect "/cakes/#{cake.id}"
                else
                    redirect "/cakes/new"
                end
            else
                redirect "/errors/new_cake_error"
            end
        else
            redirect "/errors/new_cake_error"
        end
    end

    get '/cakes/:id' do
        cake = Cake.find_by(id: params["id"])
        if cake
            if logged_in?
                user = current_user
                if cake.user == user.id
                    @user = user
                    @cake = cake
                    erb :'/cakes/show'
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

    get '/cakes/:id/edit' do
        cake = Cake.find_by(id: params["id"])
        if cake
            if logged_in?
                user = current_user
                if cake.user == user.id
                    @user = user
                    @cake = cake
                    erb :'/cakes/edit'
                else
                    redirect "/errors/error"
                end
            else
                redirect '/'
            end
        else
            if logged_in?
                redirect "/errors/not_found"
            else
                redirect '/'
            end
        end
    end


    get '/errors/edit_cake_error' do
        if logged_in?
            erb :"/errors/edit_cake_error"
        else
            redirect "/"
        end
    end

      get '/errors/new_cake_error' do
        if logged_in?
            erb :"/errors/new_cake_error"
        else
            redirect "/"
        end
      end


     

    
    patch '/cakes/:id' do
        cake = Cake.find(params["id"])
        hours_string = params["cake"]["cook_time"]
        if hours_string.match?(/\A-?(?:\d+(?:\.\d*)?|\.\d+)\z/)
            hours = hours_string.to_f
                if params["cake"]["name"] != "" && params["cake"]["recipe"] != "" && params["cake"]["cook_time"] != ""
                    cake.update(name: params["cake"]["name"],recipe: params["cake"]["recipe"],cook_time: params["cake"]["cook_time"])
                    redirect "/cakes/#{cake.id}"
                else
                    redirect "/errors/edit_cake_error"
                end
        else
            redirect "/errors/edit_cake_error"
        end
    end

    delete '/cakes/:id/delete' do
        if current_user == Cake.find(params["id"]).user
            Cake.delete(params["id"])
            redirect "/cakes"
        else
            redirect "/errors/error"
        end
    end
end