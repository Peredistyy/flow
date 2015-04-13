require 'rails_helper'

RSpec.describe 'SignIn', type: :feature, js: true do
  scenario 'Visitor authorization successfully via auth form' do
    user = create :user
    sign_in user
    expect(page).not_to have_content I18n.t('sign_in_button')
    expect(page).to have_content I18n.t('sign_out')
  end
end