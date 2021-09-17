class UserController < ApplicationController

    get '/subscriptions' do
        if logged_in?
            erb :'user/show'
        else
            redirect to '/login'
        end 
    end

    get '/signup' do
        if !logged_in?
            erb :'user/create_user'
        else
            redirect to '/subscriptions'
        end 
    end

    post '/signup' do
        if  params[:email] != "" && params[:password] != "" 
            @user = User.create(email: params[:email], password:params[:password] )
            session[:user_id] = @user.id
            redirect to "/subscriptions"
        else
            #flash message
            redirect to '/signup'
        end
    end

    get '/login' do
        if !logged_in?
            erb :'user/login'
        else
            redirect to '/subscriptions'
        end
    end

    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/subscriptions'
        else
            redirect to '/signup'
        end
    end

    get '/logout' do
        if logged_in?
             session.destroy
             #flash message
             redirect to '/login'
        else
             redirect to '/'
        end
    end

end