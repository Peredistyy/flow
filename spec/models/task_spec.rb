require 'rails_helper'

RSpec.describe Task, :type => :model do
  it 'as json' do
    task = create :task

    expected = {
        id: task.id,
        title: task.title,
        done: task.done,
        order: task.order,
        deadline: task.deadline,
        project_id: task.project.id,
        user_id: task.user.id
    }

    expect(task.to_json).to eq(expected.to_json)
  end

  it 'valid object' do
    task = create :task

    expect(task).to be_valid
  end

  it 'title presence' do
    task = build :task, title: ''

    expect(task).not_to be_valid
  end

  it 'sort order asc' do
    create :task, title: 'task3', order: 1
    create :task, title: 'task1', order: 2
    create :task, title: 'task2', order: 3

    titles = []
    Task.all.each do |task|
      titles << task.title
    end

    expect(titles).to eq(['task3', 'task1', 'task2'])
  end

  it 'comments dependent destroy' do
    task = create :task
    comment = create :comment
    task.comments << comment

    task.destroy

    expect(Comment.exists?(comment)).to be false
  end
end