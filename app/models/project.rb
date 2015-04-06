class Project < ActiveRecord::Base

  validates :title, uniqueness: true, presence: true

  belongs_to :user
  has_many :tasks, dependent: :destroy

  def as_json(options=nil)
    super(
        include: {
            tasks: {
                only: [ :id, :title, :done, :deadline ],
                include: {
                    comments: {
                        only: [ :id, :message, :attach_file_name ],
                        :methods => [ :attach_url ]
                    }
                }
            }
        }
    )
  end

end
