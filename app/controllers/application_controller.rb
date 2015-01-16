class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper


  private

  def signed_in_user
    unless signed_in?
      store_location
      flash[:danger] = "Proszę, zaloguj się."
      redirect_to signin_url
    end
  end
end
