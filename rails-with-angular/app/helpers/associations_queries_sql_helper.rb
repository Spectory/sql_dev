module AssociationsQueriesSqlHelper
  module_function

  ####### JOIN #######
  def student_courses(student_id)
    sql = "SELECT * FROM courses INNER JOIN courses_students ON courses.id = courses_students.course_id WHERE courses_students.student_id = #{student_id}"
    ActiveRecord::Base.connection.execute(sql)
  end

  def gryffindor_students_names
    sql = "
      SELECT first_name, last_name
      FROM students, houses
      WHERE students .house_id = houses.id
      AND houses .name = 'gryffindor'
    "
    ActiveRecord::Base.connection.execute(sql)
  end

  def students_with_houses
    sql = "
      SELECT *
      FROM students, houses
      WHERE  students.house_id = houses.id
    "
    ActiveRecord::Base.connection.execute(sql)
  end
end
