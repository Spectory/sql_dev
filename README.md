#Relational DB

Basic Consent & Terminologies
-----------------------------

##### What is RDBMS?
RDBMS stands for **Relational Database Management System**.
RDBMS is the basis for SQL, and for all modern database systems like MS SQL Server, Postgres, sqlite...

##### What is SQL?
SQL stands for **Structured Query Language**, which is a computer language for storing, manipulating and retrieving data stored in relational database.

##### What is Table?
a table is the most common and simplest form of data storage in a relational database

##### What is record/row?
A record, also called a row of data, is each individual entry that exists in a table.

##### What is column?
A column is a vertical entity in a table that contains all information associated with a specific field in a table.

| id | first_name | last_name | catch_phrase       |               |
|----|------------|-----------|--------------------|---------------|
| 1  | johny      | bravo     | man I'm pretty     | <- record/row |
| 2  | elmaer     | fudge     | be vewi vewi quiet |               |
| 3  | ...        | ...       | ...                |               |
|    |            |           | ^ column           |               |

##### What is ORM?
**Object-Relational Mapping**, commonly referred to as its abbreviation ORM, is a technique that connects the rich objects of an application to tables in a relational database management system. Using ORM, the properties and relationships of the objects in an application can be easily stored and retrieved from a database **without writing SQL statements directly** and with less overall database access code.
For example, ActiveRecord (at rails apps) & Ecto (at PhoenixFramework).

Queries
-------
#####Insert
The SQL INSERT INTO Statement is used to add new rows of data to a table in the database.

```Ruby
  Student.create(first_name: "Johny", last_name: "Bravo", age: 25
```

```SQL
  INSERT INTO students (first_name, last_name, age) VALUES ('Johny', 'Bravo', 25)
```

#####Select
SQL SELECT statement is used to fetch the data from a database table which returns data in the form of result table. These result tables are called result-sets.

```Ruby
  Student.first
```

```SQL
  SELECT * FROM students ORDER BY id LIMIT 1
```

##### Where
The SQL WHERE clause is used to specify a condition while fetching the data from single table or joining with multiple tables.

```Ruby
  Student.where('age < 30')
```

```SQL
  SELECT * FROM students WHERE age < 30
```

##### Join
An SQL JOIN clause is used to combine rows from two or more tables, based on a common field between them.

The most common type of join is: SQL INNER JOIN (simple join). An SQL INNER JOIN returns all rows from multiple tables where the join condition is met.


```SQL
  SELECT students.*, houses.*
  FROM students
  INNER JOIN houses
  ON students.house_id = houses.id
```
Note that we don't really need to pull each student & houses data into memory. we can specify which fields are required for our purpose.

```SQL
  SELECT students.id as student_id ,  houses.name as houses_name
  FROM students
  INNER JOIN houses
  ON students.house_id = houses.id
```

##### Composed Queries
You can link AR relations

```Ruby
  Student.where('age < 30').select(:first_name, :last_name)
```

```SQL
  SELECT first_name, last_name FROM students WHERE age < 30
```

Relations/Associations
----------------------

belongs_to
has_many
many_to_many

best practices
--------------

###### Use AR build in methods

```Ruby
  Course.ids
  Student.where(id: [1, 5, 23]) # use arrays at queiries
  House.find_by_name(house_name) # find_by helpers
```

###### find_or_create
```Ruby
  emails = %w(mama@email.com papa.email.com)
  # not so good
  emails.each do |e| 
    u = Users.find_by_email(e)
    unless u Users.create(email: e)
  end
  # better
  emails.each {|e| User.find_or_create_by(email: e)}
```
###### Move ruby logic down to db queries.
```ruby
  def students_names_and_courses
    Student.all.map do |s|
      res = []
      s.courses.each do |c| res.push({
        first_name: s.first_name,
        last_name: s.last_name,
        course_name: c.name
        })
      end
      res
    end
  end
```

```SQL
  SELECT students.first_name as first_name, students.last_name as last_name, courses.name as course_name
  FROM courses_students 
  JOIN courses ON courses_students.course_id = courses.id
  JOIN students  ON courses_students.student_id = students .id
```
####Recurses

http://www.tutorialspoint.com/sql/index.html
http://guides.rubyonrails.org/active_record_querying.html
