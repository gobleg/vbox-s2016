class Employee < ActiveRecord::Base
  #has_attached_file :video
  #validates_attachment_content_type :video, content_type: /\Avideo/
  #validates_attachment_file_name :video, matches: [/mp4\Z/]
  belongs_to :user
  has_many :locations
  has_many :videos
end
