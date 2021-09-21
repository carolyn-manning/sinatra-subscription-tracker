
class SubscriptionController < ApplicationController

    get '/create_subscription' do
        if logged_in?
            erb :'subscription/create_subscription'
        else 
            #flash[:message] = "Please log in to continue."
            redirect to '/login'
        end
    end

    post '/create_subscription' do
        if params[:name] == ""
            redirect to '/create_subscription'
        else
            @subscription = Subscription.create(name: params[:name], price: params[:price], billing_frequency: params[:billing_frequency], renewal_date: params[:renewal_date])
            @subscription.user = current_user
            @subscription.save
            redirect to '/subscriptions'
        end       
    end

    get '/subscriptions/:id' do
        if logged_in?
            @subscription = Subscription.find_by(id: params[:id])
            if @subscription && @subscription.user == current_user 
                erb :'subscription/show_subscription'
            else
                #flash[:message] = "Please log in to continue."
                redirect to '/login'
            end 
        else 
            #flash[:message] = "Please log in to continue."
            redirect to '/login'
        end
    end

    get '/subscriptions/:id/edit' do
        if logged_in?
            @subscription = Subscription.find_by(id: params[:id])
            if @subscription && @subscription.user == current_user 
                erb :'subscription/edit_subscription'
            else
                #flash[:message] = "Successfully updated subscription."
                redirect to '/subscriptions'
            end 
        else 
            flash[:message] = "Successfully updated song."
            redirect to '/login'
        end
    end

    patch '/subscriptions/:id' do
        @subscription = Subscription.find_by(id: params[:id])
        @subscription.update(price: params[:price], billing_frequency: params[:billing_frequency], renewal_date: params[:renewal_date])
        redirect to "/subscriptions"
    end

    delete '/subscriptions/:id/delete' do
        @subscription = Subscription.find_by(id: params[:id])
        if @subscription.user_id == current_user.id 
            @subscription.delete
            redirect to "/subscriptions"
        else 
            redirect to '/login'
        end 
    end


end