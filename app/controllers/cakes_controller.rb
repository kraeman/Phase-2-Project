class CakesController < ApplicationController

    get '/cakes' do
        if !logged_in?(session)
            redirect '/'
        else    
            # redirect_if_not_logged_in(session)
            @user = current_user(session)
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
        if !logged_in?(session)
            redirect '/'
        else
            @user = current_user(session)
            erb :'/cakes/new'
        end
    end

    post '/cakes' do
        hours_string = params["cake"]["cook_time"]
        if hours_string.match?(/\A-?(?:\d+(?:\.\d*)?|\.\d+)\z/)
            hours = hours_string.to_f
            if params["cake"]["name"] != "" && params["cake"]["recipe"] != "" && params["cake"]["cook_time"] != ""
                cake = Cake.create(name: params["cake"]["name"],recipe: params["cake"]["recipe"],cook_time: hours)
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
        else
            erb :"/new_cake_error"
        end
    end

    get '/cakes/:id' do
        begin
            Cake.find(params["id"])
        rescue
            erb :'/not_found'
        else
        # if !Cake.find(params["id"])
        #     erb :'/not_found'
        # end
            if !logged_in?(session)
                redirect '/'
            else
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
        end
    end

    get '/cakes/:id/edit' do
        begin
            Cake.find(params["id"])
        rescue
            erb :'/not_found'
        else
            if !logged_in?(session)
                redirect '/'
            else
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
                    @cake = cake
                    erb :"/edit_cake_error"
                end
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