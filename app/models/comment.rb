class Comment < ActiveRecord::Base

  validates :message, presence: true

  has_attached_file :attach
  do_not_validate_attachment_file_type :attach

  belongs_to :task
  belongs_to :user

  def as_json(options=nil)
    super(
        only: [ :id, :message, :attach_file_name ],
        :methods => [ :attach_url ]
    )
  end

  def attach_url
    attach.url if attach?
  end

end
