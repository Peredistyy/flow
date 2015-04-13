require 'rails_helper'

RSpec.describe 'SignOut', type: :feature, js: true do
  scenario 'SignOut' do
    user = create :user
    sign_in user

    click_link I18n.t('sign_out')

    expect(page).not_to have_content I18n.t('sign_out')
    expect(page).to have_content I18n.t('sign_in_button')
    expect(page).to have_content I18n.t('sign_up_button')
  end
end