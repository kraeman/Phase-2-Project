class UserController < ApplicationController

    get '/users/new' do
        @ingredients = Ingredient.all
        @people = Person.all
        erb :'/cakes/new'
    end

    get '/users/:id/edit' do
        @user = User.find(params["id"])
        @array = [true, false]
        erb :'/users/edit'
    end

    get '/users/account' do
    
        @user_id = session[:user_id]
        @user = User.find(@user_id)
        erb :'/users/account'
    end

    post '/users' do
        @user = User.create(params["user"])
 
        unless params[]
            @cake. << .create(params[""])
        end

        unless params[]
            @cake. << .create(params[""])
        end
        
        @user.save
    
        redirect to "/users/#{@user.id}"
    end

    patch '/users/:id' do
        @user = User.find(params["id"])
        @user.ingredients = Ingredient.find_or_create_by(name: params['landmark']['name'])

        @user.update(name: params["user"]["name"])
        unless params[""]["name"].empty?
            @cake.ingredients << Title.create(name: params[""]["name"])
        
        end
        unless params[""]["name"].empty?
            @cake.user = User.create(name: params[""]["name"])
        end

        @user.save

        redirect "users/#{@user.id}"
    end
end