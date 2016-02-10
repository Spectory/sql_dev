module StudentHelper
  AGE_RANGE = (20..90).to_a

  module AR
    module_function

    ########### INSERT ##########
    def add
      i = Student.count
      Student.create(first_name: "fname_#{i}", last_name: "lname_#{i}", age: AGE_RANGE.sample)
    end

    def bulk_insert(n)
      (1..n).each { add }
    end

    ########### SELECT ##########
    def all
      Student.all
    end

    def first
      Student.first
    end

    def first_names
      Student.select(:first_name)
    end

    ########### WHERE ##########
    def young
      Student.where('age < 30')
    end

    ########### Composed Querys ##########

    def youngsters_names
      Student.where('age < 30').select(:first_name, :last_name)
    end
  end

  module SQL
    module_function

    ########### INSERT ##########
    def add
      i = Student.count
      sql = "INSERT INTO students (first_name, last_name, age) VALUES ('fname_#{i}', 'lname_#{i}', #{AGE_RANGE.sample})"
      ActiveRecord::Base.connection.execute(sql)
    end

    def bulk_insert(n)
      c = Student.count
      values = (c..c + n).map { |i| "('fname_#{i}', 'lname_#{i}', #{AGE_RANGE.sample})" }.join(', ')
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
    def young
      sql = 'SELECT * FROM students WHERE age < 30'
      ActiveRecord::Base.connection.execute(sql)
    end

    ########### Composed Querys ##########
    def youngsters_names
      sql = 'SELECT first_name, last_name FROM students WHERE age < 30'
      ActiveRecord::Base.connection.execute(sql)
    end
  end
end
