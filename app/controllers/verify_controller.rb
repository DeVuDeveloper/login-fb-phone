
class VerifyController < ApplicationController
    skip_before_action :redirect_if_unverified
  
  
    def new
      @user= current_user
    end
  
     def create
      current_user.send_pin!
      redirect_to verify_url, notice: 'Verification code has ben sent to your mobile number.'
    end
  
    def edit
      @user= current_user
    end
  
    
    
   def update
     @user= current_user
        if Time.now > current_user.pin_sent_at.advance(minutes: 60)
          flash.now[:alert] = 'Your pin has expired. Please request another.'
          render :new and return
        elsif params[:user][:pin].try(:to_i) == current_user.pin
          current_user.update_attribute(:verified, true)
          redirect_to root_url, notice: 'Your phone number has been verified!'
        else
          flash.now[:alert] = 'The code you entered is invalid.'
          render :edit
        end
      end
    end
