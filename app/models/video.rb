class Video < ActiveRecord::Base
  has_attached_file :dash_video
  belongs_to :employee
end
