require 'spec_helper'

describe 'AssociationsQueriesSqlHelper' do
  before(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end

  describe 'student_courses' do
    student = nil
    before do
      Course.create!(name: 'course 1')
      Course.create!(name: 'course 2')
      student = Student.create!(first_name: 'first_name', last_name: 'last_name', age: 13)
      student.courses = Course.all
      student.save!
    end
    it 'should return courses that student is taking' do
      res = AssociationsQueriesSqlHelper.student_courses(student.id)
      expect(res.count).to be 2
    end
  end

  describe 'students_of_house' do
    house_with_students = nil
    house_without_students = nil
    before do
      house_with_students = House.create(name: 'house 1')
      house_without_students = House.create(name: 'house 2')
      Student.create!(first_name: 'first_name', last_name: 'last_name', age: 13, house_id: house_with_students.id)
    end
    it 'should return all students of given house name' do
      res = AssociationsQueriesSqlHelper.students_of_house(house_with_students.name)
      expect(res.count).to be 1
      res = AssociationsQueriesSqlHelper.students_of_house(house_without_students.name)
      expect(res.count).to be 0
    end
  end

  describe 'students_with_houses' do
    before do
      house_with_students = House.create(name: 'house 1')
      Student.create!(first_name: 'first_name', last_name: 'last_name', age: 13, house_id: house_with_students.id)
      Student.create!(first_name: 'first_name1', last_name: 'last_name1', age: 11, house_id: house_with_students.id)
      Student.create!(first_name: 'first_name2', last_name: 'last_name2', age: 12)
    end
    it 'should return all students that are assiged to a house' do
      res = AssociationsQueriesSqlHelper.students_with_houses
      expect(res.count).to be 2
    end
  end
end
