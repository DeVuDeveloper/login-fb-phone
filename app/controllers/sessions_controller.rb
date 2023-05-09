class SessionsController < Devise::SessionsController
    def destroy
      session[:user_id] = nil  
      current_user.delete  
      redirect_to root_path
    end 
end