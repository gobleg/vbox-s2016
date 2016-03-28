class Employee < ActiveRecord::Base
  belongs_to :user
  has_many :location
end
