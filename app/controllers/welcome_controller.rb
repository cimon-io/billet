class WelcomeController < ApplicationController
  protect_from_forgery with: :exception

  def index
    head :ok
  end

end
