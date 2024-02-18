
--имя + работа
SELECT human.first_name AS Имя, job.job_title AS Должность
FROM human JOIN job ON human.job_id = job.id;

--имя + действия + предмет действия
SELECT human.first_name AS Имя, action_table.action_name AS Действие, item.item_name AS Предмет
FROM action_table 
JOIN human ON action_table.human_id = human.id
JOIN item ON action_table.item_id = item.id;

--локация + имя + работа
SELECT location_table.location_name AS Локация, human.first_name AS Имя, job.job_title AS Должность
FROM human
JOIN location_table ON human.location_id = location_table.id
JOIN job ON human.job_id = job.id;

--все
SELECT location_table.location_name AS Локация, human.first_name AS Имя, job.job_title AS Должность,
action_table.action_name AS Действие, item.item_name AS Предмет
FROM action_table
JOIN human ON action_table.human_id = human.id
JOIN item ON action_table.item_id = item.id
JOIN location_table ON human.location_id = location_table.id
JOIN job ON human.job_id = job.id;