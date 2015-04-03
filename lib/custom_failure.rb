class CustomFailure < Devise::FailureApp

  def redirect_url
    root_path
  end

  def respond
    if request.format == :json || request.content_type == 'application/json'
      super
    else
      http_auth? ? http_auth : redirect
    end
  end

end