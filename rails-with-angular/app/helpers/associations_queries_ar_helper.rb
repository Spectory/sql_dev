module AssociationsQueriesArHelper
  module_function

  ########### Associations Queries ##########

  def student_courses(student_id)
    Student.find(student_id).courses
  end

  def gryffindor_students
    Student.where(house: House.find_by_name('gryffindor'))
  end
end
