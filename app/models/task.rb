class Task < ActiveRecord::Base

  validates :title, presence: true

  default_scope { order order: :asc }

  belongs_to :project
  belongs_to :user
  has_many :comments, dependent: :destroy

  def as_json(options=nil)
    super(
        only: [ :id, :title, :done, :order, :deadline, :project_id, :user_id ]
    )
  end

end
