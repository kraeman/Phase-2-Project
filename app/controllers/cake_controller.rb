class CakeController < ApplicationController
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
            @cake.titles << Title.create(params["title"])
        end

        unless params[]
            @cake.landmarks << Landmark.create(params["landmark"])
        end
        
        @cake.save
    
        redirect to "/cakes/#{@cake.id}"
    end

    patch '/cakes/:id' do
        
    end
end