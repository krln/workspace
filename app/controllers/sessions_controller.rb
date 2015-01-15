class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        sign_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "Konto nie zostało aktywowane."
        message += "Link aktywacyjny został wysłany na twojego maila, sprawdź go, aby aktywować."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Nieprawidłowy email lub hasło'
      render 'new'
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_url
  end
end
