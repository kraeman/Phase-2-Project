class IngredientController < ApplicationController
    get '/cakes' do
        @cakes = Cake.all
        erb :'/cakes/index'
    end

    get '/cakes/new' do
        @ingredients = Ingredient.all
        @people = Person.all
        erb :'/cakes/new'
    end

    get '/cakes/:id/edit' do
        @cake = Cake.find()
        @ingredients = Ingredient.all
        @people = Person.all
        erb :'/cakes/edit'
    end

    get '/cakes/:id' do
        @cake = Cakes.find()
        erb :'/cakes/show'
    end

    post '/cakes' do
        @cake = Cake.create(params["cake"])
 
        unless params[]
            @cake. << .create(params[""])
        end

        unless params[]
            @cake. << .create(params[""])
        end
        
        @cake.save
    
        redirect to "/cakes/#{@cake.id}"
    end

    patch '/cakes/:id' do
        @cake = Cake.find(params["id"])
        @cake.ingredients = Ingredient.find_or_create_by(name: params['landmark']['name'])

        @cake.update(name: params["cake"]["name"])
        unless params[""]["name"].empty?
            @cake.ingredients << Title.create(name: params[""]["name"])
        
        end
        unless params[""]["name"].empty?
            @cake.user = User.create(name: params[""]["name"])
        end

        @cake.save

        redirect "cakes/#{@cake.id}"
    end
end