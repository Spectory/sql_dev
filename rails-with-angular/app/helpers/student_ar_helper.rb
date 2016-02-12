module StudentArHelper
  AGE_RANGE = (10..18).to_a

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
  def under_16
    Student.where('age < 16')
  end

  def students_under_16_full_name
    Student.where('age < 16').select(:first_name, :last_name)
  end
end
