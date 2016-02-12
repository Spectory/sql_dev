module AssociationsQueriesSqlHelper
  module_function

  ####### JOIN #######
  def student_courses(student_id)
    sql = "SELECT * FROM courses INNER JOIN courses_students ON courses.id = courses_students.course_id WHERE courses_students.student_id = #{student_id}"
    ActiveRecord::Base.connection.execute(sql)
  end

  def students_of_house(house_name)
    sql = "
      SELECT *
      FROM students, houses
      WHERE students .house_id = houses.id
      AND houses .name = '#{house_name}'
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
