require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, :type => :model do
  describe 'abilities of loggined user' do
    subject { ability }
    let(:ability) { Ability.new(user) }
    let(:user){ FactoryGirl.create(:user) }

    let(:project) { create :project, user: user }
    let(:project_negative) { create :project }

    context 'for project' do
      it { expect(ability).to be_able_to(:create, Project) }
      it { expect(ability).to be_able_to(:read, project) }
      it { expect(ability).to be_able_to(:update, project) }
      it { expect(ability).to be_able_to(:destroy, project) }

      it { expect(ability).not_to be_able_to(:read, project_negative) }
      it { expect(ability).not_to be_able_to(:update, project_negative) }
      it { expect(ability).not_to be_able_to(:destroy, project_negative) }
    end

    let(:task) { create :task, user: user }
    let(:task_negative) { create :task }

    context 'for task' do
      it { expect(ability).to be_able_to(:create, Task) }
      it { expect(ability).to be_able_to(:read, task) }
      it { expect(ability).to be_able_to(:update, task) }
      it { expect(ability).to be_able_to(:destroy, task) }

      it { expect(ability).not_to be_able_to(:read, task_negative) }
      it { expect(ability).not_to be_able_to(:update, task_negative) }
      it { expect(ability).not_to be_able_to(:destroy, task_negative) }
    end

    let(:comment) { create :comment, user: user }
    let(:comment_negative) { create :comment }

    context 'for comment' do
      it { expect(ability).to be_able_to(:create, Comment) }
      it { expect(ability).to be_able_to(:read, comment) }
      it { expect(ability).to be_able_to(:update, comment) }
      it { expect(ability).to be_able_to(:destroy, comment) }

      it { expect(ability).not_to be_able_to(:read, comment_negative) }
      it { expect(ability).not_to be_able_to(:update, comment_negative) }
      it { expect(ability).not_to be_able_to(:destroy, comment_negative) }
    end
  end
end