module TipsAndTricks
  module_function

  # Get fileds from colums without building AR objects by using pluck
  def courses_ids()
    Course.ids
  end
  def courses_names()
    Course.pluck(:name)
  end
  def courses_ids_and_names()
    Course.pluck(:id, :name)
  end

  # use arrays at queries
  def students_by_ids(ids)
    Student.where(id: ids)
  end
  def students_by_first_names(first_names)
    Student.where(first_name: first_names)
  end

  # find_by helpers
  def first_student_from_house(house_name)
    Student.find_by_house_id(House.find_by_name(house_name).id)
  end

  # find_or_create
  def find_or_create_house(name)
    House.find_or_create_by(name: name)
  end

  # exists?
  def is_a_course(names)
    Course.exists?(name: names)
  end

  # calculations
  def students_avg_age
    Student.average(:age).to_int
  end

  def students_min_age
    Student.minimum(:age)
  end

  def students_max_age
    Student.maximum(:age)
  end

  def students_sum_age
    Student.sum(:age)
  end
end