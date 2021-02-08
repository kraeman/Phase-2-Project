class InviteController < ApplicationController
    get '/invites' do
        @invites = Invite.all
        erb :'/invites/index'
    end

    get '/invites/new' do
        @people = Person.all
        erb :'/invites/new'
    end

    get '/invites/:id/edit' do
        @people = Person.all
        erb :'/invites/edit'
    end

    get '/invite/:id' do
        @invite = Invite.find(params["id"])
        erb :'/invites/show'
    end

    post '/invite' do
        @invite = Invite.create(params["invite"])
 
        unless params[]
            @invite. << .create(params[""])
        end

        unless params[]
            @invite. << .create(params[""])
        end
        
        @invite.save
    
        redirect to "/invite/#{@invite.id}"
    end

    patch '/invite/:id' do
        @invite = Invite.find(params["id"])
        @invite.message = params["message"]

        @invite.update(name: params["invite"]["name"])
        unless params[""]["name"].empty?
            @invite.ingredients << Title.create(name: params[""]["name"])
        
        end
        unless params[""]["name"].empty?
            @invite.user = User.create(name: params[""]["name"])
        end

        @invite.save

        redirect "invite/#{@invite.id}"
    end
end