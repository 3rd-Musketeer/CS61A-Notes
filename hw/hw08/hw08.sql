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


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT dog.name, size.size from dogs as dog, sizes as size
  where dog.height > size.min and dog.height <= size.max;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT parents.child from parents, dogs where parents.parent = dogs.name order by dogs.height desc;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT A.child as ca, B.child as cb from parents as A, parents as B
  where A.parent = B.parent and A.child < B.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT A.ca || " and " || A.cb || " are " || B.size || " siblings" from siblings as A, size_of_dogs as B, size_of_dogs as C
  where (B.name = A.ca and C.name = A.cb and B.size = C.size);


-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
INSERT INTO stacks_helper1 
SELECT name as dog, height as stack_height, height as last_height 
FROM dogs;

INSERT INTO stacks_helper2 
SELECT a.dog, b.dog, a.stack_height + b.stack_height, b.last_height
FROM stacks_helper1 as a, stacks_helper1 as b
WHERE a.dog != b.dog AND a.last_height <= b.last_height;

INSERT INTO stacks_helper3 
SELECT a.dog1, a.dog2, b.dog, a.stack_height + b.stack_height, b.last_height
FROM stacks_helper2 as a, stacks_helper1 as b
WHERE a.dog1 != b.dog AND a.dog2 != b.dog AND a.last_height <= b.last_height;

INSERT INTO stacks_helper4 
SELECT a.dog1, a.dog2, a.dog3, b.dog, a.stack_height + b.stack_height, b.last_height
FROM stacks_helper3 as a, stacks_helper1 as b
WHERE a.dog1 != b.dog AND a.dog2 != b.dog AND a.dog3 != b.dog AND a.last_height <= b.last_height;

CREATE TABLE stacks AS
  SELECT dog1 || ", " || dog2 || ", " || dog3 || ", " || dog4, (distinct stack_height)
  FROM stacks_helper4 ORDER BY stack_height;

