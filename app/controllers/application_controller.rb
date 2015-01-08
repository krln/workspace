class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  def hello
      render text: "¡Hola, mundo!"
  end

#  def goodbye
#      render text: "goodbye, world!"
#  end
end
