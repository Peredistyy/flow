require 'rails_helper'

RSpec.describe 'Project', type: :feature, js: true do

  def add_project
    within "form[name='add_project']" do
      click_button I18n.t('add_project_button')
      fill_in 'project_title', with: 'NewProject'
      click_button I18n.t('add_project_button')
    end
  end

  scenario 'Create new project' do
    user = create :user
    sign_in user
    add_project
    expect(page).to have_selector('lable', text: 'NewProject')
  end

  scenario 'Update project title' do
    user = create :user
    sign_in user
    add_project

    within '.panel-project .panel-heading' do
      first('.project-edit').click
      first("input[type='text']").set('NewTitleProject')
      click_button I18n.t('save')
    end

    expect(page).to have_selector('lable', text: 'NewTitleProject')
  end

  scenario 'Delete project' do
    user = create :user
    sign_in user
    add_project

    within '.panel-project .panel-heading' do
      first('.project-delete').click
    end

    within '.modal-dialog' do
      click_button 'yes'
    end

    expect(page).not_to have_selector('lable', text: 'NewProject')
  end
end