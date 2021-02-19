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
                cake.owner_id = current_user.id
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
        begin
            Cake.find(params["id"])
        rescue
            if logged_in?
                @user = current_user
                redirect "/errors/not_found"
            else
                redirect '/'
            end
        else
            if !logged_in?
                redirect '/'
            else
                user = current_user
                cake = Cake.find(params["id"])
                if cake.owner_id == user.id
                    @user = user
                    @cake = cake
                    erb :'/cakes/show'
                else
                    @user = user
                    if logged_in?
                        redirect "/errors/error"
                    else
                        redirect '/'
                    end
                end
            end
        end
    end

    get '/cakes/:id/edit' do
        begin
            Cake.find(params["id"])
        rescue
            if logged_in?
                @user = current_user
                redirect "/errors/not_found"
            else
                redirect '/'
            end
        else
            if !logged_in?
                redirect '/'
            else
                cake = Cake.find(params["id"])
                user = current_user
                if cake.owner_id == user.id
                    @user = user
                    @cake = cake
                    erb :'/cakes/edit'
                else
                    @user = user
                    if logged_in?
                        redirect "/errors/error"
                    else
                        redirect '/'
                    end
                end
            end
        end
    end


    get '/errors/edit_cake_error' do
      erb :"/errors/edit_cake_error"
    end

      get '/errors/new_cake_error' do
        erb :"/errors/new_cake_error"
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
        Cake.delete(params["id"])
        redirect "/cakes"
    end
end