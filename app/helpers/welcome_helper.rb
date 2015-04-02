module WelcomeHelper

  def user_resource_name
    :user
  end

  def user_resource
    @resource ||= User.new
  end

  def password_length
    Devise.password_length
  end

end
