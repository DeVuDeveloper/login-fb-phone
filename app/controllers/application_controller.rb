class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery 
  
  
  
    helper_method :resource
  
   
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |u|
        u.permit(:email, :phone, :password, :password_confirmation, :uid, :provider)
      end
      devise_parameter_sanitizer.permit(:sign_in) do |u|
        u.permit(:email, :phone, :password, :password_confirmation, :uid, :provider)
      end
      devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit(:email, :phone, :password, :password_confirmation, :uid, :provider)
      end
    end
  end
