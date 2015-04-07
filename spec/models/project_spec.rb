require 'rails_helper'

RSpec.describe Project, :type => :model do
  it 'as json' do
    project = create :project
    task = create :task
    comment = create :comment

    task.comments << comment
    project.tasks << task

    expected = {
        id: project.id,
        title: project.title,
        tasks: [
            {
                id: task.id,
                title: task.title,
                done: task.done,
                deadline: task.deadline,
                comments: [
                    {
                        id: comment.id,
                        message: comment.message,
                        attach_file_name: comment.attach_file_name,
                        attach_url: comment.attach_url
                    }
                ]
            }
        ]
    }

    expect(project.to_json).to eq(expected.to_json)
  end

  it 'valid object' do
    project = create :project

    expect(project).to be_valid
  end

  it 'title presence' do
    project = build :project, title: ''

    expect(project).not_to be_valid
  end

  it 'title uniqueness' do
    create :project, title: 'Title'
    project2 = build :project, title: 'Title'

    expect(project2).not_to be_valid
  end

  it 'tasks dependent destroy' do
    project = create :project
    task = create :task
    project.tasks << task

    project.destroy

    expect(Task.exists?(task)).to be false
  end
end