module AssociationsQueriesArHelper
  module_function

  ########### Associations Queries ##########

  def student_courses(student_id)
    Student.find(student_id).courses
  end
  def student_courses_sql_translation(student_id)
    students = ActiveRecord::Base.connection.execute("
      SELECT  students.* 
      FROM students 
      WHERE students.id = #{student_id} 
      LIMIT 1
      ")
    ActiveRecord::Base.connection.execute("
      SELECT courses.*
      FROM courses
      INNER JOIN courses_students ON courses.id = courses_students.course_id
      WHERE courses_students.student_id = #{students[0]['id']}
      ")
  end

  def students_of_house(house_name)
    Student.where(house: House.find_by_name(house_name))
  end
  def students_of_house_sql_translation(house_name)
    houses = ActiveRecord::Base.connection.execute("
       SELECT houses.*
       FROM houses
       WHERE houses.name = '#{house_name}'
       LIMIT 1
      ")
    ap houses
    ActiveRecord::Base.connection.execute("
      SELECT students.*
      FROM students
      WHERE students.house_id = #{houses[0]['id']}
      ")
  end

  def students_from_house_that_take_course(course_name, house_name)
    Course.find_by_name(course_name).students.where(house: House.find_by_name(house_name))
  end
  def students_from_house_that_take_course_sql_translation(course_name, house_name)
    courses = ActiveRecord::Base.connection.execute("
      SELECT courses.*
      FROM courses
      WHERE courses.name = '#{course_name}'
      LIMIT 1
      ")
    houses = ActiveRecord::Base.connection.execute("
      SELECT houses.*
      FROM houses
      WHERE houses.name = '#{house_name}'
      LIMIT 1
      ")
    ActiveRecord::Base.connection.execute("
      SELECT students.*
      FROM students
      INNER JOIN courses_students ON students.id = courses_students.student_id
      WHERE courses_students.course_id = #{courses[0]['id']}
      AND students.house_id = #{houses[0]['id']}
      ")
  end
end
