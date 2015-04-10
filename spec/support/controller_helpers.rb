module ControllerHelpers

  protected

    def moke_current_ability
      @current_user = login_user

      @ability = Object.new
      @ability.extend(CanCan::Ability)
      allow(controller).to receive(:current_ability).and_return(@ability)
      @ability.can :manage, :all, :user_id => @current_user.id
    end

    def access_denied_expected
      { success: false, error: CanCan::AccessDenied.new.message }
    end

  private

    def login_user
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = create(:user)
      sign_in user
      user
    end

end