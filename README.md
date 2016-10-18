# DB Mapper

## Setup

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

1. Then, following tables will be generated.
  * `schools`
  * `houses`
  * `students`
