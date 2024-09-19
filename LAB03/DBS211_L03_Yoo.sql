-- ***********************
-- Name: Chaerin Yoo
-- ID: 102998234
-- Date: 2024-05-29
-- Purpose: Lab 03 DBS211
-- ***********************

SET AUTOCOMMIT ON; 


--Q1. Create the following tables and their given constraints:
CREATE TABLE L5_MOVIES (
    m_id INT PRIMARY KEY,
    title VARCHAR2(35) NOT NULL,
    release_year INT NOT NULL,
    director INT NOT NULL,
    score DECIMAL(3, 2) CHECK (score > 0 AND score < 5)
);

CREATE TABLE L5_ACTORS (
    a_id INT PRIMARY KEY,
    first_name VARCHAR2(20) NOT NULL,
    last_name VARCHAR2(30) NOT NULL
);

CREATE TABLE L5_CASTINGS (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES L5_MOVIES(m_id),
    FOREIGN KEY (actor_id) REFERENCES L5_ACTORS(a_id)
);

CREATE TABLE L5_DIRECTORS (
    director_id INT PRIMARY KEY,
    first_name VARCHAR2(20) NOT NULL,
    last_name VARCHAR2(30) NOT NULL
);

--Q2. Modify the L5_MOVIES table to create a foreign key constraint that refers to table L5_DIRECTORS. 
ALTER TABLE L5_MOVIES
ADD CONSTRAINT fk_director
FOREIGN KEY (director) REFERENCES L5_DIRECTORS(director_id);

--03. Modify the L5_MOVIES table to create a new constraint so the uniqueness of the movie title is guaranteed. 
ALTER TABLE L5_MOVIES
ADD CONSTRAINT uq_movie_title
UNIQUE (title);

--Q4. Write insert statements to add the following data to table L5_DIRECTORS and L5_MOVIES.
-- L5_DIRECTORS
INSERT INTO L5_DIRECTORS (director_id, first_name, last_name) VALUES (1010, 'Rob', 'Minkoff');
INSERT INTO L5_DIRECTORS (director_id, first_name, last_name) VALUES (1020, 'Bill', 'Condon');
INSERT INTO L5_DIRECTORS (director_id, first_name, last_name) VALUES (1050, 'Josh', 'Cooley');
INSERT INTO L5_DIRECTORS (director_id, first_name, last_name) VALUES (2010, 'Brad', 'Bird');
INSERT INTO L5_DIRECTORS (director_id, first_name, last_name) VALUES (3020, 'Lake', 'Bell');

-- L5_MOVIES
INSERT INTO L5_MOVIES (m_id, title, release_year, director, score) VALUES (100, 'The Lion King', 2019, 3020, 3.50);
INSERT INTO L5_MOVIES (m_id, title, release_year, director, score) VALUES (200, 'Beauty and the Beast', 2017, 1050, 4.20);
INSERT INTO L5_MOVIES (m_id, title, release_year, director, score) VALUES (300, 'Toy Story 4', 2019, 1020, 4.50);
INSERT INTO L5_MOVIES (m_id, title, release_year, director, score) VALUES (400, 'Mission Impossible', 2018, 2010, 5.00);
INSERT INTO L5_MOVIES (m_id, title, release_year, director, score) VALUES (500, 'The Secret Life of Pets', 2016, 1010, 3.90);

--Q5. 5.	Write SQL statements to remove all above tables. 
--Is the order of tables important when removing? Why? 
--A. Because of foreign key constraints, the order in which tables are deleted is very important. 
--Because it has foreign keys that point to these tables, L5_CASTINGS needs both L5_MOVIES and L5_ACTORS to work. To get rid of the reliance, L5_CASTINGS should be dropped first. 
--Then it can drop L5_MOVIES and L5_ACTORS in any order. 
--Finally, it can drop L5_DIRECTORS because it is linked to L5_MOVIES. Because of the way foreign keys work, dropping tables out of order could cause problems.

DROP TABLE L5_CASTINGS;
DROP TABLE L5_MOVIES;
DROP TABLE L5_ACTORS;
DROP TABLE L5_DIRECTORS;







