class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      sign_in user
      flash[:success] = "Konto zostało uaktywnione!"
      redirect_to user
    else
      flash[:danger] = "Nieprawidłowy link aktywacyjny"
      redirect_to root_url
    end
  end
end
