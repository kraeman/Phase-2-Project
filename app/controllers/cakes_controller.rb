class CakeController < ApplicationController

    get '/cakes' do
     
        @session = session
        @cakes_for_me = []
        @cakes_by_me = []
        Cake.all.each do |cake|
            if belongs_to_current_user_as_receiver?(cake, @session)
                @cakes_for_me << cake
            end
            if belongs_to_current_user_as_giver?(cake, @session)
                @cakes_by_me << cake
            end
        end
        erb :'/cakes/index'
    end

    get '/cakes/new' do
        @users = User.all
        erb :'/cakes/new'
    end

    get '/cakes/:id/edit' do
        @cake = Cake.find(params["id"])
        @ingredients = Ingredient.all
        @people = Person.all
        erb :'/cakes/edit'
    end

    get '/cakes/:id' do
        @cake = Cake.find(params["id"])
        erb :'/cakes/show'
    end

    post '/cakes' do
        binding.pry
        @cake = Cake.create(params["cake"])
 
        # unless params["cake_name"]
        #     @cake.giver_id = User.find_or_create_by(name: params["giver"])
        # end

        # unless params["cake_recipe"]
        #     @cake.receiver_id = User.find_or_create_by(name: params["receiver"])
        # end
    
        redirect "/cakes/#{@cake.id}"
    end

    patch '/cakes/:id' do
        @cake = Cake.find(params["id"])
        @cake.ingredients = Ingredient.find_or_create_by(name: params['']['name'])

        @cake.update(name: params["cake"]["name"])
        unless params[""]["name"].empty?
            @cake.ingredients << Title.create(name: params[""]["name"])
        
        end
        unless params[""]["name"].empty?
            @cake.user = User.create(name: params[""]["name"])
        end

        @cake.save

        redirect "/cakes/#{@cake.id}"
    end
end