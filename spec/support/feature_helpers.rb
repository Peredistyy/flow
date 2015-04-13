module FeatureHelpers

  protected

  def sign_in(user)
    visit root_path
    within '#signInForm' do
      fill_in  User.human_attribute_name('email'), with: user.email
      fill_in User.human_attribute_name('password'), with: user.password
      click_button I18n.t('sign_in_button')
    end
  end

end