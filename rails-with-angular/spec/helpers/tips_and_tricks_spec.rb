require 'spec_helper'

describe 'TipsAndTricks' do
  before(:each) do
    DatabaseCleaner.clean_with(:truncation)
    @c1 = Course.create(name: 'a')
    @c2 = Course.create(name: 'b')
    @h1 = House.create(name: 'h')
    @s1 = Student.create(first_name: '1', age: 10, house_id: @h1.id)
    @s2 = Student.create(first_name: '2', age: 12)
  end

  describe 'courses_ids' do
    it 'should return array of courses ids' do
      expected_res = [@c1.id, @c2.id]
      res = TipsAndTricks.courses_ids
      expect(res).to match_array(expected_res)
    end
  end

  describe 'courses_names' do
    it 'should return array of courses names' do
      expected_res = [@c1.name, @c2.name]
      res = TipsAndTricks.courses_names
      expect(res).to match_array(expected_res)
    end
  end

  describe 'courses_ids_and_names' do
    it 'should return array of courses names' do
      expected_res = [[@c1.id, @c1.name], [@c2.id, @c2.name]]
      res = TipsAndTricks.courses_ids_and_names
      expect(res).to match_array(expected_res)
    end
  end

  describe 'students_by_ids' do
    it 'should return students with matching id' do
      invaild_id = 1233
      expected_res = [@s1]
      res = TipsAndTricks.students_by_ids([@s1.id, invaild_id])
      expect(res).to match_array(expected_res)
    end
  end

  describe 'students_by_first_names' do
    it 'should return students with matching frist_names' do
      invalid_name = 'invalid_name'
      expected_res = [@s1]
      res = TipsAndTricks.students_by_first_names([@s1.first_name, invalid_name])
      expect(res).to match_array(expected_res)
    end
  end

  describe 'first_student_from_house' do
    it 'should return the first student of named house' do
      expected_res = @s1
      res = TipsAndTricks.first_student_from_house(@h1.name)
      expect(res).to eq(expected_res)
    end
  end

  describe 'find_or_create_house' do
    it 'should create only one house by given name' do
      name = 'new house'
      expect(House.find_by(name: name)).to be nil
      new_house = TipsAndTricks.find_or_create_house(name)
      expect(House.find_by(name: name)).to eq new_house
    end
  end

  describe 'is_a_course' do
    it 'should return true if any of the courses names match an existing course' do
      res = TipsAndTricks.is_a_course(['mama', 'papa', @c1.name])
      expect(res).to be true
    end
    it "should return false if all of the courses names doesn't match an existing course" do
      res = TipsAndTricks.is_a_course(%w(mama papa))
      expect(res).to be false
    end
  end

  it 'students_avg_age' do
    expected_res = (@s1.age + @s2.age) / 2
    res = TipsAndTricks.students_avg_age
    expect(res).to eq(expected_res)
  end

  it 'students_min_age' do
    expected_res = [@s1.age, @s2.age].min
    res = TipsAndTricks.students_min_age
    expect(res).to eq(expected_res)
  end

  it 'students_max_age' do
    expected_res = [@s1.age, @s2.age].max
    res = TipsAndTricks.students_max_age
    expect(res).to eq(expected_res)
  end

  it 'students_sum_age' do
    expected_res = @s1.age + @s2.age
    res = TipsAndTricks.students_sum_age
    expect(res).to eq(expected_res)
  end
end
