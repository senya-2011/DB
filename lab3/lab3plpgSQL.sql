UPDATE location_table SET id=id WHERE id=1;

SELECT * from distances;
SELECT * from location_table;

INSERT INTO location_table (name, coords) VALUES ('Деревня', '(-123, 3132)');

--вывод
SELECT location1.name AS локация1, location2.name AS локация2, distances.distance AS расстояние
FROM distances JOIN location_table AS location1 ON distances.location1_id = location1.id
JOIN location_table AS location2 ON distances.location2_id = location2.id;



--функция
CREATE OR REPLACE FUNCTION update_distances()
RETURNS TRIGGER AS $$
DECLARE
    id_1 int;
    id_2 int;
	
    location1_coords point;
    location2_coords point;
	
	x_1 real;
	x_2 real;
	y_1 real;
	y_2 real;
	
	distance real;
BEGIN
    FOR id_1 IN SELECT id FROM location_table LOOP
        FOR id_2 IN SELECT id FROM location_table WHERE id <> id_1 LOOP
            IF NOT EXISTS (
                SELECT 1 FROM distances 
                WHERE (distances.location1_id = id_1 AND distances.location2_id = id_2)
                OR (distances.location1_id = id_2 AND distances.location2_id = id_1)
            ) THEN
				RAISE NOTICE 'подсчет расстояния между локациями % и %', id_1, id_2;
                SELECT coords INTO location1_coords FROM location_table WHERE id = id_1;
                SELECT coords INTO location2_coords FROM location_table WHERE id = id_2;
				x_1 = location1_coords[0];
				x_2 = location2_coords[0];
				y_1 = location1_coords[1];
				y_2 = location2_coords[1];
				distance := SQRT((x_1-x_2)*(x_1-x_2)+(y_1-y_2)*(y_1-y_2));
				
                INSERT INTO distances (location1_id, location2_id, distance)
                VALUES (id_1, id_2, distance);
            END IF;
        END LOOP;
    END LOOP;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

--тригер
CREATE OR REPLACE TRIGGER update_distances_trigger
AFTER INSERT OR UPDATE OR DELETE ON location_table
FOR EACH ROW EXECUTE FUNCTION update_distances();