module StudentSqlHelper
  AGE_RANGE = (10..18).to_a

  module_function

  ########### INSERT ##########
  def add
    i = Student.count
    sql = "INSERT INTO students (first_name, last_name, age) VALUES ('fname_#{i}', 'lname_#{i}', #{AGE_RANGE.sample})"
    ActiveRecord::Base.connection.execute(sql)
  end

  def bulk_insert(n)
    c = Student.count
    values = (c + 1..c + n).map { |i| "('fname_#{i}', 'lname_#{i}', #{AGE_RANGE.sample})" }.join(', ')
    sql = "INSERT INTO students (first_name, last_name, age) VALUES #{values}"
    ActiveRecord::Base.connection.execute(sql)
  end

  ########### SELECT ##########
  def first
    sql = 'SELECT * FROM students ORDER BY id LIMIT 1'
    ActiveRecord::Base.connection.execute(sql)
  end

  def all
    sql = 'SELECT * FROM students'
    ActiveRecord::Base.connection.execute(sql)
  end

  def first_names
    sql = 'SELECT first_name FROM students'
    ActiveRecord::Base.connection.execute(sql)
  end

  ########### WHERE ##########
  def under_16
    sql = 'SELECT * FROM students WHERE age < 16'
    ActiveRecord::Base.connection.execute(sql)
  end

  def students_under_16_full_name
    sql = 'SELECT first_name, last_name FROM students WHERE age < 16'
    ActiveRecord::Base.connection.execute(sql)
  end
end
