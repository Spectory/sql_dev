module AssociationsQueriesArHelper
  module_function

  ########### Associations Queries ##########

  def student_courses(student_id)
    Student.find(student_id).courses
  end

  def students_of_house(house_name)
    Student.where(house: House.find_by_name(house_name))
  end
end
