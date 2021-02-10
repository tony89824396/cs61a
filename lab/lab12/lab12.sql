.read sp17data.sql
.read fa17data.sql

CREATE TABLE obedience AS
  SELECT seven, denero, hilfinger from  students;

CREATE TABLE smallest_int AS
  SELECT Time,smallest from students where smallest >18 order by smallest asc limit 20;

CREATE TABLE greatstudents AS
  SELECT a.date,a.color,a.pet,a.number,b.number FROM students as a, sp17students as b
  where a.date==b.date and a.color==b.color and a.pet=b.pet;

CREATE TABLE sevens AS
  SELECT a.seven from students as a, checkboxes as b where a.time=b.time and a.number ==7 and b."7" == "True";

CREATE TABLE matchmaker AS
  SELECT a.pet, a.song, a.color, b.color from students as a, students as b
  where a.pet==b.pet and a.song==b.song and a.time<b.time
