class Student < ActiveRecord::Base
  belongs_to :house
  has_and_belongs_to_many :courses

  def my_house_name
    house.name
  end

  def self.first_student_house_name
    Student.first.house.name
  end
end
