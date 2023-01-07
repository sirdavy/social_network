# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO students (name, cohort_name) VALUES ('Anna', 'May 2022');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Post

attr_accessor :id, :title, :content, :views

end



# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  def all
    # Executes the SQL query:
    SELECT * FROM posts;
    # Returns an array of post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    SELECT * FROM posts WHERE id = $1;
    # Returns a single post object.
  end

  def create(new_post)
    INSERT INTO posts (title, content, views) VALUES($1, $2, $3);
  end

  def delete (id)
     DELETE FROM posts WHERE id = $1;
  end



## 6. Write Test Examples

```ruby

# 1
# Gets all posts

repo = PostRepository.new
all_posts = repo.all
all_posts.length # =>  2
all_posts[0].id # =>  1
all_posts[0].title # =>  'Great nibbles'
all_posts[0].content # => 'Liver, fava beans, chianti'
all_posts[0].views # => 10
all_posts[0].user_id # => 1
all_posts[1].id # =>  1
all_posts[1].title # =>  'Why everyone sucks'
all_posts[1].content # => 'Is it just me or do...'
all_posts[1].views # => 9
all_posts[1].user_id # => 2

# 2
# Gets a single post

repo = PostRepository.new

sing_post = repo.find(1)
sing_post.id # =>  1
sing_post.title # =>  'Great nibbles'
sing_post.content # => 'Liver, fava beans, chianti'
sing_post.views # => 10
sing_post.user_id # => 1


# 3
# Creates a new user

repo = StudentRepository.new
new_user = User.new
new_user.username = 'Basil'
new_user.email = 'baz@fawltytowers.co.uk'
repo.create(new_user)
repo.all # includes new_user

# 4
# Deletes a user

repo = StudentRepository.new
repo.delete(1)
repo.all # => not include  'Hannibal', 'hannibubs@lector.com'

```














# 1
# Get all students

repo = StudentRepository.new

students = repo.all

students.length # =>  2

students[0].id # =>  1
students[0].name # =>  'David'
students[0].cohort_name # =>  'April 2022'

students[1].id # =>  2
students[1].name # =>  'Anna'
students[1].cohort_name # =>  'May 2022'

# 2
# Get a single student

repo = StudentRepository.new

student = repo.find(1)

student.id # =>  1
student.name # =>  'David'
student.cohort_name # =>  'April 2022'

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._


