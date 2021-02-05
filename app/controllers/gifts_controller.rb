class GiftController < ApplicationController
    get '/gifts' do
        @gifts = Gift.all
        erb :'/gifts/index'
    end

    get '/gifts/new' do
        @giver = Ingredient.all
        @receiver = Person.all
        erb :'/gifts/new'
    end

    get '/gifts/:id/edit' do
        @gift = gift.find()
        @ingredients = Ingredient.all
        @people = Person.all
        erb :'/gifts/edit'
    end

    get '/gifts/:id' do
        @gift = gifts.find()
        erb :'/gifts/show'
    end

    post '/gifts' do
        @gift = gift.create(params["gift"])
 
        unless params[]
            @gift.titles << Title.create(params["title"])
        end

        unless params[]
            @gift.landmarks << Landmark.create(params["landmark"])
        end
        
        @gift.save
    
        redirect to "/gifts/#{@gift.id}"
    end

    patch '/gifts/:id' do
        @gift = gift.find(params["id"])
        @gift.ingredients = Ingredient.find_or_create_by(name: params['landmark']['name'])

        @gift.update(name: params["gift"]["name"])
        unless params[""]["name"].empty?
            @gift.ingredients << Title.create(name: params[""]["name"])
        
        end
        unless params[""]["name"].empty?
            @gift.user = User.create(name: params[""]["name"])
        end

        @gift.save

        redirect "gifts/#{@gift.id}"
    end
end