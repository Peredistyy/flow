require 'rails_helper'

RSpec.describe 'SignUp', type: :feature, js: true do
  scenario 'Visitor registers successfully via register form' do
    visit root_path
    within '#signUpForm' do
      fill_in User.human_attribute_name('email'), with: Faker::Internet.email
      fill_in User.human_attribute_name('password'), with: 'fake_password'
      fill_in User.human_attribute_name('password_confirmation'), with: 'fake_password'
      click_button I18n.t('sign_up_button')
    end
    expect(page).not_to have_content I18n.t('sign_up_button')
    expect(page).to have_content I18n.t('sign_out')
  end
end