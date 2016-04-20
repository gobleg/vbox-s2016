class Video < ActiveRecord::Base
  has_attached_file :dash_video
  validates_attachment_content_type :dash_video, :content_type => "video/mp4"
  belongs_to :employee
end
