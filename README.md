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

1. Then, following tables will be generated in `wizards.db`.
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
- `::columns`
- `::all`
- `::find(id)`
- `#update`
- `#insert`
- `#save`

## Searchable

- `::where`: takes an hash as an argument and returns an array of objects that satisfy the argument's condition(s).

## Associatable

- `::belongs_to`
- `::has_many`
- `::has_one_through`
