class Task < ActiveRecord::Base

  validates :title, presence: true

  default_scope { order('`order` ASC') }

  belongs_to :project
  belongs_to :user

end
