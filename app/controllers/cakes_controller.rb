class CakesController < ApplicationController

    get '/cakes' do
        redirect_if_not_logged_in 
        @cakes_by_me = current_user.cakes
        erb :'/cakes/index'
    end

    get '/cakes/new' do
        redirect_if_not_logged_in
        erb :'/cakes/new'
    end

    post '/cakes' do
        redirect_if_not_logged_in
        hours_string = params["cake"]["cook_time"]
        cake = current_user.cakes.build(params["cake"])
        if hours_string.match?(/\A-?(?:\d+(?:\.\d*)?|\.\d+)\z/) && cake.valid?
            hours = hours_string.to_f
            cake.save
            redirect "/cakes/#{cake.id}"
        else
            redirect "/errors/new_cake_error"
        end
    end

    get '/cakes/:id' do
        redirect_if_not_logged_in
        @cake = current_user.cakes.find_by(id: params["id"])
        user = current_user
        if @cake
            if @cake.user.id == user.id
                erb :'/cakes/show'
            else
                redirect "/errors/error"
            end
        else
            redirect "/errors/not_found"
        end
    end

    get '/cakes/:id/edit' do
        redirect_if_not_logged_in
        @cake = current_user.cakes.find_by(id: params["id"])
        if @cake
                user = current_user
                if @cake.user.id == user.id
                    erb :'/cakes/edit'
                else
                    redirect "/errors/error"
                end
        else
                redirect "/errors/not_found"
        end
    end


    get '/errors/edit_cake_error' do
        redirect_if_not_logged_in
        erb :"/errors/edit_cake_error"
    end

      get '/errors/new_cake_error' do
        redirect_if_not_logged_in
            erb :"/errors/new_cake_error"
      end

    patch '/cakes/:id' do
        redirect_if_not_logged_in
        cake = current_user.cakes.find(params["id"])
        hours_string = params["cake"]["cook_time"]
        if hours_string.match?(/\A-?(?:\d+(?:\.\d*)?|\.\d+)\z/) && cake.valid?
            hours = hours_string.to_f
            cake.update(params["cake"])
            cake.save
            redirect "/cakes/#{cake.id}"
        else
            redirect "/errors/edit_cake_error"
        end
    end

    delete '/cakes/:id/delete' do
        if logged_in? && current_user == Cake.find(params["id"]).user
            current_user.cakes.delete(params["id"])
            redirect "/cakes"
        else
            redirect "/errors/error"
        end
    end
end