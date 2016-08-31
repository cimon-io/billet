class WelcomeController < ApplicationController
  protect_from_forgery with: :exception

  def index
    render nothing: true
  end

end
