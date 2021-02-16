class CakesController < ApplicationController
    # before("/coins") do
    #     redirect_if_not_logged_in if request.path_info != "/login"
    # end

    get '/cakes' do
        redirect_if_not_logged_in(session)
        @user = current_user(session)
        @cakes_by_me = []
     
        Cake.all.each do |cake|
            if belongs_to_current_user?(cake, session)
                @cakes_by_me << cake
            end
        end
        erb :'/cakes/index'
    end

    get '/cakes/new' do
        @user = current_user(session)
        erb :'/cakes/new'
    end

    post '/cakes' do
   
        if params["cake"]["name"] != "" && params["cake"]["recipe"] != "" && params["cake"]["cook_time"] != ""
            cake = Cake.create(params["cake"])
            cake.owner_id = current_user(session).id
            cake.save
            if cake.valid? 
                redirect "/cakes/#{cake.id}"
            else
                redirect "/cakes/new"
            end
        else
            erb :"/new_cake_error"
        end
    end

    get '/cakes/:id' do
        user = current_user(session)
        cake = Cake.find(params["id"])
        if cake.owner_id == user.id
            @user = user
            @cake = cake
            erb :'/cakes/show'
        else
            erb :'error'
        end
    end

    get '/cakes/:id/edit' do
        cake = Cake.find(params["id"])
        user = current_user(session)
        if cake.owner_id == user.id
            @user = user
            @cake = cake
            erb :'/cakes/edit'
        else
            erb :'error'
        end
    end

    
    patch '/cakes/:id' do
        cake = Cake.find(params["id"])
        if params["cake"]["name"] != "" && params["cake"]["recipe"] != "" && params["cake"]["cook_time"] != ""
            cake.update(name: params["cake"]["name"],recipe: params["cake"]["recipe"],cook_time: params["cake"]["cook_time"])
            # cake.save
            redirect "/cakes/#{cake.id}"
        else
            @cake = cake
            erb :"/edit_cake_error"
        end
    end

    delete '/cakes/:id/delete' do
        Cake.delete(params["id"])
        redirect "/cakes"
    end
end