.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet from students where color = 'blue' and pet = 'dog';

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song from students where color = 'blue' and pet = 'dog';


CREATE TABLE matchmaker AS
  SELECT A.pet, A.song, A.color, B.color from students as A, students as B
  where A.time < B.time and A.pet = B.pet and A.song = B.song;


CREATE TABLE sevens AS
  SELECT A.seven from students as A, numbers as B
  where A.time = B.time and A.number = 7 and B.'7' = 'True';


CREATE TABLE favpets AS
  SELECT pet, count(*) from students group by pet order by -count(*) limit 10;


CREATE TABLE dog AS
  SELECT * from favpets where pet = 'dog';


CREATE TABLE bluedog_agg AS
  SELECT song, count(*) from bluedog_songs group by song order by -count(*);


CREATE TABLE instructor_obedience AS
  SELECT seven, instructor, count(*) from students where seven = '7' group by instructor;

