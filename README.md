# DB Mapper
DB Mapper is an Object Relational Mapping framework which allows manipulating a database without explicitly writing SQL statements.

### Example
You can run following commands on your computer to run demo.

1. Clone the repository into your working directory.
  ```
  $ git clone https://github.com/echeon/db-mapper.git
  ```

1. Go to `db-mapper` folder and run `bundle install`.
  ```
  $ cd db-mapper
  $ bundle install
  ```

1. Create SQLite3 tables by running the following command.
  ```
  $ cat wizards.sql | sqlite3 wizards.db
  ```

1. Then, following tables will be generated and `wizards.db` file will be created.
  * `schools`
  * `houses`
  * `students`

1. Open `pry` and require the demo file.
  ```
  $ pry
  [1] pry(main) > require_relative 'demo'
  ```
  This example has three models: `School`, `House`, `Student`.
  ```ruby
  class School < SQLObject
    has_many :houses
  end

  class House < SQLObject
    belongs_to :school
    has_many :students
  end

  class Student < SQLObject
    belongs_to :house
    has_one_through :school, :house, :school
  end

  ```

1. Play around! You can also run your own example by creating your own database and models. Just don't forget to add `require_relative 'lib/sql_object'` to your model file(s). Also, they all should inherit from `SQLObject`!


## SQLObject

- `::new`
  initializes an instance with provided hash
  ```
  [2] pry(main) > School.new(name: "Castelobruxo")
  => #<School:0x007fdda831bc98 @attributes={:name=>"Castelobruxo"}>
  ```

- `::columns`
  takes no arguments and returns an array of column names
  ```
  [3] pry(main)> Student.columns
  => [:id, :name, :house_id]
  ```

- `::all`
  takes no arguments and returns all objects in a class
  ```
  [4] pry(main) > House.all
  => [#<House:0x007fdda82e0a80 @attributes={:id=>1, :name=>"Gryffindor", :school_id=>1}>, ...]
  ```

- `::find(id)`
  takes an integer as an argument and returns an object with matching id.
  ```
  [5] pry(main) > Student.find(1)
  => #<Student:0x007fdda8ab9d88 @attributes={:id=>1, :name=>"Harry Potter", :house_id=>1}>
  ```

- `#insert`
  inserts a new data to the database
  ```
  [6] pry(main) > school = School.new(name: "Castelobruxo")
  [7] pry(main) > school.insert
  [8] pry(main) > School.all
  => [...,
      #<School:0x007fdda818aac8 @attributes={:id=>4, :name=>"Castelobruxo"}>]
  ```

- `#update`
  saves updated attributes to the database
  ```
  [9] pry(main) > school = School.find(1)
  => #<School:0x007fdda89b0ae0 @attributes={:id=>1, :name=>"Hogwarts"}>
  [10] pry(main) > school.name = "Hogwarts School of Witchcraft and Wizardry"
  [11] pry(main) > school.update
  [12] pry(main) > School.find(1)
  => #<School:0x007fdda89b0ae0 @attributes={:id=>1, :name=>"Hogwarts School of Witchcraft and Wizardry"}>
  ```

- `#save`
  saves a new record using `#insert` if it doesn't exist in the database. OR, it saves with updated attributes to the database using `#update` if the record already exists in the database


## Searchable

- `::where`
  takes an hash as an argument and returns an array of object(s) that satisfy the argument's condition(s)
  ```
  [13] pry(main) > Student.where(name: "Hermione Granger")
  => [#<Student:0x007fb7e48cee90 @attributes={:id=>2, :name=>"Hermione Granger", :house_id=>1}>]
  ```

## Associatable

- `::belongs_to`
  is equivalent to Rails Active Record's `belongs_to` association
  ```
  [14] pry(main) > harry = Student.find(1)
  [15] pry(main) > harry.house
  => #<House:0x007f90fe0f0578 @attributes={:id=>1, :name=>"Gryffindor", :school_id=>1}>
  ```

- `::has_many`
  is equivalent to Rails Active Record's `has_many` association
  ```
  [16] pry(main) > gryffindor = House.find(1)
  [17] pry(main) > gryffindor.students
  => [#<Student:0x007f90fc80ee10 @attributes={:id=>1, :name=>"Harry Potter", :house_id=>1}>,
      #<Student:0x007f90fc80e0a0 @attributes={:id=>2, :name=>"Hermione Granger", :house_id=>1}>,
      #<Student:0x007f90fc80dd80 @attributes={:id=>3, :name=>"Ronald Weasley", :house_id=>1}>,
      #<Student:0x007f90fc80dbc8 @attributes={:id=>4, :name=>"Neville Longbottom", :house_id=>1}>,
      #<Student:0x007f90fc80d998 @attributes={:id=>5, :name=>"Dean Thomas", :house_id=>1}>]
  ```

- `::has_one_through`
  is equivalent to Rails Active Record's `has_many :through` association
  ```
  [18] pry(main) > draco = Student.where(name: "Draco Malfoy").first
  [19] pry(main) > draco.school
  => #<School:0x007f90fc39db60 @attributes={:id=>1, :name=>"Hogwarts School of Witchcraft and Wizardry"}>
  ```
