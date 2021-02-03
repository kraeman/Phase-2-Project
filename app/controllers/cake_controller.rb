class CakeController < ApplicationController
    get '/cakes' do
        erb :'/cakes/index'
    end

    get '/cakes/new' do
        erb :'/cakes/new'
    end

    get '/cakes/:id/edit' do
        erb :'/cakes/new'
    end

    get '/cakes/:id' do
        erb :'/cakes/new'
    end

    post '/cakes' do
        @cake = Cake.create()
    end

    patch '/cakes/:id' do
        
    end
end