require 'rails_helper'

RSpec.describe 'Task', type: :feature, js: true do

  def add_project
    within "form[name='add_project']" do
      click_button I18n.t('add_project_button')
      fill_in 'project_title', with: 'NewProject'
      click_button I18n.t('add_project_button')
    end
  end

  def add_task
    within "form[name='add_task']" do
      fill_in 'task_title', with: 'NewTask'
      click_button I18n.t('add_task_button')
    end
  end

  scenario 'Create new task' do
    user = create :user
    sign_in user
    add_project
    add_task

    expect(page).to have_selector('lable', text: 'NewTask')
  end

  scenario 'Update title task' do
    user = create :user
    sign_in user
    add_project
    add_task

    within '.table-tasks' do
      find('.project-task-edit').click

      within '.task-edit-from' do
        first("input[type='text']").set('NewTitleTask')
        click_button I18n.t('save')
      end
    end

    expect(page).to have_selector('lable', text: 'NewTitleTask')
  end

  scenario 'Done task' do
    user = create :user
    sign_in user
    add_project
    add_task

    within '.table-tasks' do
      find('.project-task-open').click
      find('.done').first("input[type='checkbox']").set(true)
    end

    expect(page).to have_css('table.table-tasks tr.done')
  end

  scenario 'Delete task' do
    user = create :user
    sign_in user
    add_project
    add_task

    within '.table-tasks' do
      find('.project-task-delete').click
    end

    within '.modal-dialog' do
      click_button 'yes'
    end

    expect(page).not_to have_selector('lable', text: 'NewTask')
  end

end