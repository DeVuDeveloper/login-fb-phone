class VerifyPinService

   
    def update_verified(user)
    
        if Time.now > user.pin_sent_at.advance(minutes: 60)
            flash.now[:alert] = 'Your pin has expired. Please request another.'
            render :new and return
          elsif params[:user][:pin].try(:to_i) == user.pin
            user.update_attribute(:verified, true)
            redirect_to root_url, notice: 'Your phone number has been verified!'
          else
            flash.now[:alert] = 'The code you entered is invalid.'
            render :edit
          end
        end
    end
  