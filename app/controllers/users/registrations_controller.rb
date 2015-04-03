class Users::RegistrationsController < Devise::RegistrationsController

  respond_to :json

  def create
    user = User.new(user_params)

    if user.save
      sign_in(:user, user)
      render json: { success: true }
    else
      render json: { success: false, errors: user.errors.full_messages }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end