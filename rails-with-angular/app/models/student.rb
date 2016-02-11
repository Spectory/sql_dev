class Student < ActiveRecord::Base
  belongs_to :house
  has_and_belongs_to_many :courses
end
