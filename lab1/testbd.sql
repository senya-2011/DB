DROP TABLE IF EXISTS people, job;
-- delete old tables 

CREATE TABLE job
(
	job_id int PRIMARY KEY,
	job_name text NOT NULL,
	job_money int NOT NULL
);

CREATE TABLE people
(
	people_id int PRIMARY KEY,
	first_name text NOT NULL,
	last_name text NOT NULL,
	isWork Boolean NOT NULL,
	job_id int REFERENCES job(job_id)
);
--create new tables

INSERT INTO job
VALUES
(1, 'Programmist', 1000),
(2, 'Builder', 800),
(3, 'GayMer', 5000),
(4, 'ChlenoSOS', 100000);

INSERT INTO people
VALUES
(1, 'Паша', 'Дуров', 'true', 1),
(2, 'Леша', 'Иванов', 'false', NULL),
(3, 'ЧИлен', 'Маяковский', 'true', 3),
(4, 'Иван', 'Петров', 'true', 2),
(5, 'Илон', 'Маск', 'true', 1),
(6, 'Валера', 'ПИВО', 'true', 2);


SELECT first_name, last_name, job_name, job_money
FROM people JOIN job ON people.job_id = job.job_id
ORDER BY job_money DESC



