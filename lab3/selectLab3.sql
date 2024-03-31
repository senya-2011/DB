--имя + пол + локация
SELECT human.name, sex.sex, location_table.name AS локация
FROM human JOIN sex ON human.sex_id = sex.id
JOIN location_table ON human.location_id = location_table.id;

--имя + пол + локация + характеристика
SELECT human.name, sex.sex, location_table.name, location_table.name AS локация,
characteristic.characterisctic AS характеристика
FROM human_characteristic
JOIN human ON human_characteristic.human_id = human.id
JOIN characteristic ON human_characteristic.characteristic_id = characteristic.id
JOIN sex ON human.sex_id = sex.id
JOIN location_table ON human.location_id = location_table.id;

--имя + действие + предмет
SELECT human.name, action_table.act AS действие, item.name AS предмет
FROM action_table 
JOIN human ON action_table.human_id = human.id
JOIN item ON action_table.item_id = item.id;

--звезды
SELECT item.name AS звезда
FROM star JOIN item ON star.item_id = item.id;

--места
SELECT * from location_table;

--distance
SELECT location1.name AS локация1, location2.name AS локация2, distances.distance AS расстояние
FROM distances JOIN location_table AS location1 ON distances.location1_id = location1.id
JOIN location_table AS location2 ON distances.location2_id = location2.id;