class IngredientController < ApplicationController
    get '/ingredients' do
        @ingredients = Ingredient.all
        erb :'/cakes/index'
    end

    get '/ingredients/new' do
        erb :'/ingredients/new'
    end

    get '/ingredients/:id/edit' do
        @ingredient = Ingredient.find(params[id])
        erb :'/ingredients/edit'
    end

    get '/ingredients/:id' do
        @ingredient = Ingredient.find(params[id])
        erb :'/ingredients/show'
    end

    post '/ingredients' do
        @ingredient = Ingredient.create(params["ingredient"])
        
        @ingredient.save
    
        redirect to "/ingredients/#{@ingredient.id}"
    end

    patch '/ingredients/:id' do
        @ingredient = Ingredient.find(params["id"])
        @ingredient.ingredients = Ingredient.find_or_create_by(name: params['landmark']['name'])

        @ingredient.update(name: params["ingredient"]["name"])
        unless params[""]["name"].empty?
            @ingredient.ingredients << Title.create(name: params[""]["name"])
        
        end
        unless params["ingredient"]["price"].empty?
            @ingredient.price = params["ingredient"]["price"]
        end

        @ingredient.save

        redirect "ingredients/#{@ingredient.id}"
    end
end