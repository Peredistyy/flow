class WelcomeController < ApplicationController

  def index
    if user_signed_in?
      redirect_to url_for(controller: :lists, action: :index)
    end
  end

end