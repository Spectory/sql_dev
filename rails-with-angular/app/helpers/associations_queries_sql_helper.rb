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
      SELECT students.*
      FROM students, houses
      WHERE  students.house_id = houses.id
    "
    ActiveRecord::Base.connection.execute(sql)
  end
  def students_with_houses_2
    sql = "
      SELECT students.*
      FROM students
      INNER JOIN houses
      ON students.house_id = houses.id
    "
    ActiveRecord::Base.connection.execute(sql)
  end

  def students_from_house_that_take_course(course_name, house_name)
    sql = "
      SELECT  students.*
      FROM students
      INNER JOIN courses_students
      ON students.id = courses_students.student_id
      WHERE courses_students.course_id = ?
      AND students.house_id = 2
      ORDER BY students.id
      ASC
    "
  end

  def students_names_and_courses
    sql = "
    SELECT students.first_name as first_name, students.last_name as last_name, courses.name as course_name
    FROM courses_students 
    JOIN courses ON courses_students.course_id = courses.id
    JOIN students  ON courses_students.student_id = students .id
    "
    ActiveRecord::Base.connection.execute(sql)
  end
end
