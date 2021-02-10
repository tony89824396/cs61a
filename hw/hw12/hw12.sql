CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT a.name, b.size FROM dogs AS a, sizes as b where a.height <= b.max and a.height>b.min;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_height AS
  SELECT a.child from parents as a, dogs as b where a.parent = b.name order by b.height desc;

CREATE TABLE sibling AS
    SELECT a.child AS A, b.child AS B FROM parents AS a, parents AS b
    WHERE a.parent = b.parent AND a.child < b.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT a.A || " and " || a.B || " are " || c.size || " siblings"
  FROM sibling AS a, size_of_dogs AS c, size_of_dogs AS d
  WHERE a.A = c.name AND a.B = d.name AND c.size = d.size;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE helper(name, curr_height, prev_height);

INSERT INTO helper
    SELECT a.name, a.height, a.height
    FROM dogs as a ;

INSERT INTO helper
    SELECT a.name || ", " || b.name, a.curr_height+b.height , b.height
    FROM helper as a , dogs as b
    WHERE a.prev_height < b.height;

INSERT INTO helper
    SELECT a.name || ", " || b.name, a.curr_height+b.height , b.height
    FROM helper as a , dogs as b
    WHERE a.prev_height < b.height;

INSERT INTO helper
    SELECT a.name || ", " || b.name, a.curr_height+b.height , b.height
    FROM helper as a , dogs as b
    WHERE a.prev_height < b.height;

CREATE TABLE stacks AS
  SELECT a.name, a.curr_height
  FROM  helper as a
  WHERE a.curr_height > 170
  ORDER BY a.curr_height ASC;
