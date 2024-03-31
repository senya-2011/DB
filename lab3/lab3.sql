DROP TABLE IF EXISTS human, sex, location_table, human_characteristic, characteristic, action_table, item, star, distances;

CREATE TABLE sex
(
	id serial PRIMARY KEY,
	sex varchar(15)
);
CREATE TABLE location_table
(
	id serial PRIMARY KEY,
	name varchar(15),
	coords point
);
CREATE TABLE distances
(
	id serial PRIMARY KEY,
	location1_id int REFERENCES location_table(id),
	location2_id int REFERENCES location_table(id),
	distance real
);

CREATE TABLE human
(
	id serial PRIMARY KEY,
	location_id int REFERENCES location_table(id),
	sex_id int REFERENCES sex(id),
	name varchar(30)
);
CREATE TABLE characteristic
(
	id serial PRIMARY KEY,
	characterisctic varchar(30)
);
CREATE TABLE human_characteristic
(
	id serial PRIMARY KEY,
	human_id int REFERENCES human(id),
	characteristic_id int REFERENCES characteristic(id)
);
CREATE TABLE item
(
	id serial PRIMARY KEY,
	name varchar(30)
);
CREATE TABLE star
(
	id serial PRIMARY KEY,
	item_id int REFERENCES item(id)
);
CREATE TABLE action_table
(
	id serial PRIMARY KEY,
	human_id int REFERENCES human(id),
	item_id int REFERENCES item(id),
	act varchar(30)
);

--Заполнение таблиц
INSERT INTO location_table (name, coords) 
VALUES 
('город', '(0, 0)'), ('пустырь', '(20.123, 38.124)'), ('завод', '(5, 12)'), ('больница', '(3, 4)');

INSERT INTO sex (sex) 
VALUES 
('мужчина'), ('женщина');

INSERT INTO human (location_id, sex_id, name) 
VALUES 
(1, 1, 'мальчик'), (1, 1, 'Джизирак'),
(1, 1, 'Олвин'), (1, 2, 'Алистра');

INSERT INTO characteristic (characterisctic)
VALUES ('неповторимый'), ('талантливый'), ('эксцентричный');

INSERT INTO human_characteristic (human_id, characteristic_id)
VALUES (2, 1),(3, 2), (3, 3);

INSERT INTO item (name)
VALUES ('черточки характера'), ('поведение'), ('образ жизни'),
('влиеяние'),('стабильность'), ('ничего'), ('Солнце');

INSERT INTO star(item_id)
VALUES (7);

INSERT INTO action_table(human_id, item_id, act)
VAlUES (2, 1, 'тревожить'), (2, 2, 'ожидать'),
(3, 3, 'воспринимает'), (3, 4, 'оказать'), (2, 5, 'верил'),
(2, 6, 'придумать');