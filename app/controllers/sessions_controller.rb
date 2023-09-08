class SessionsController < ApplicationController
    def new
    end

    def create
        # binding.break
        user = User.find_by(email: params[:session][:email].downcase)
        respond_to do |format|
            if user && user.authenticate(params[:session][:password])
                    session[:user_id] = user.id
                    flash[:notice] = "Wellcome to Alpha Blog #{user.username}, you have loged in!"
                     format.html{ redirect_to user_url(user)}
                else 
                    # binding.break
                    flash.now[:notice] = "Wrong kredentials"
                    format.html{ render :new , status: :unprocessable_entity}
            end
      
        end

    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Logged out"
        redirect_to root_path
    end
end