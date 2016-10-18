CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  house_id INTEGER NOT NULL,

  FOREIGN KEY(house_id) REFERENCES houses(id)
);

CREATE TABLE houses (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  school_id INTEGER NOT NULL,

  FOREIGN KEY(school_id) REFERENCES schools(id)
);

CREATE TABLE schools (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

INSERT INTO
  schools (id, name)
VALUES
  (1, "Hogwarts"),
  (2, "Durmstrang"),
  (3, "Beauxbatons");

INSERT INTO
  houses (id, name, school_id)
VALUES
  (1, "Gryffindor", 1),
  (2, "Hufflepuff", 1),
  (3, "Ravenclaw", 1),
  (4, "Slytherin", 1);

INSERT INTO
  students (id, name, house_id)
VALUES
  (1, "Harry Potter", 1),
  (2, "Hermione Granger", 1),
  (3, "Ronald Weasley", 1),
  (4, "Neville Longbottom", 1),
  (5, "Dean Thomas", 1),
  (6, "Pomona Sprout", 2),
  (7, "Silvanus Kettleburn", 2),
  (8, "Newton Scamander", 2),
  (9, "Nymphadora Tonks", 2),
  (10, "Cedric Diggory", 2),
  (11, "Luna Lovegood", 3),
  (12, "Sybill Trelawney", 3),
  (13, "Marcus Belby", 3),
  (14, "Cho Chang", 3),
  (15, "Myrtle Warren", 3),
  (16, "Tom Marvolo Riddle", 4),
  (17, "Severus Snape", 4),
  (18, "Bellatrix Lestrange", 4),
  (19, "Draco Malfoy", 4),
  (20, "Horace Slughorn", 4);
