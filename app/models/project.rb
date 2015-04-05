class Project < ActiveRecord::Base

  validates :title, uniqueness: true, presence: true

  belongs_to :user
  has_many :tasks

  def as_json(options=nil)
    super(
        include: {
            tasks: {
                only: [ :id, :title ]
            }
        }
    )
  end

end
