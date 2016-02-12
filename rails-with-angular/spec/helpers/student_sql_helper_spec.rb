require 'spec_helper'

describe 'StudentSqlHelper' do
  before(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end

  describe 'add' do
    it 'should create student' do
      expect { StudentSqlHelper.add }.to change { Student.count }.by(1)
    end
  end

  describe 'bulk_insert' do
    it 'should create n student' do
      expect { StudentSqlHelper.bulk_insert(10) }.to change { Student.count }.by(10)
    end
  end

  describe 'all' do
    it 'should return all students' do
      expect(StudentSqlHelper.all.count).to be(0)
      Student.create(first_name: 'fname', last_name: 'lname', age: 11)
      expect(StudentSqlHelper.all.count).to be(1)
      Student.create(first_name: 'fname2', last_name: 'lname2', age: 12)
      expect(StudentSqlHelper.all.count).to be(2)
    end
  end

  describe 'first' do
    it 'should return first student' do
      expected_res = Student.create(first_name: 'fname', last_name: 'lname', age: 11)
      Student.create(first_name: 'fname2', last_name: 'lname2', age: 12)
      expect(StudentSqlHelper.first[0]['id']).to eq(expected_res.id)
    end
  end

  describe 'first_names' do
    it 'should return list of first names' do
      s1 = Student.create(first_name: 'fname', last_name: 'lname', age: 11)
      s2 = Student.create(first_name: 'fname2', last_name: 'lname2', age: 12)
      names = StudentSqlHelper.first_names.map { |h| h['first_name'] }
      expect(names).to match_array([s1.first_name, s2.first_name])
    end
  end

  describe 'under_16' do
    it 'should return list of students with age < 16' do
      Student.create(first_name: 'fname', last_name: 'lname', age: 11)
      Student.create(first_name: 'fname2', last_name: 'lname2', age: 12)
      Student.create(first_name: 'fname3', last_name: 'lname3', age: 17)
      expect(StudentSqlHelper.under_16.count).to be(2)
    end
  end

  describe 'students_under_16_full_name' do
    it 'should return list of students with age < 16' do
      Student.create(first_name: 'fname', last_name: 'lname', age: 11)
      Student.create(first_name: 'fname2', last_name: 'lname2', age: 12)
      Student.create(first_name: 'fname3', last_name: 'lname3', age: 17)
      res = StudentSqlHelper.students_under_16_full_name
      expect(res.size).to be(2)
      expect(res.first['id']).to be nil
      expect(res.first['first_name']).not_to be nil
      expect(res.first['last_name']).not_to be nil
    end
  end
end
