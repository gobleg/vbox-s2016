class Employee < ActiveRecord::Base
  belongs_to :user
  has_many :locations
  has_many :videos
end
