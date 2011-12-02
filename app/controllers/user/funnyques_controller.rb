class User::FunnyquesController < ApplicationController
  
  before_filter :authenticate_user!, :except => []

   def new
     @funnyque = current_user.funnyques.new
   end

   def create
     @funnyque = current_user.funnyques.new(params[:funnyque])
     if @funnyque.save
       flash[:notice] = "funnyques created successfully"
       redirect_to("/user/account")
     else
       render :new
     end
   end

   def edit
     @funnyque = current_user.funnyques.find(params[:id])
   end

   def update
     @funnyque = current_user.funnyques.find(params[:id])
     if @funnyque.update_attributes(params[:funnyque])
       flash[:notice] = "funnyques saved successfully"
       redirect_to("/user/account")
     else
       render :edit
     end
   end
   
end
