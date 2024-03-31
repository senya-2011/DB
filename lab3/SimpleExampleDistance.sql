DROP TABLE IF EXISTS cities, distances;

CREATE TABLE cities (
    id serial PRIMARY KEY,
    name text,
    coordinates point
);

CREATE TABLE distances (
    city1_id int REFERENCES cities(id),
    city2_id int REFERENCES cities(id),
    distance real
);

INSERT INTO cities(name, coordinates)
VALUES ('СПБ', '(100, 1919)'), ('Moscow', '(31.312, 131.13)'), ('Rostov', '(21, 11)'), ('Donesk', '(321, 228)');

SELECT * FROM cities;
SELECT * FROM distances;

SELECT cities1.name AS город1, cities2.name AS город2, distances.distance AS расстояние
FROM distances JOIN cities AS cities1 ON distances.city1_id = cities1.id
JOIN cities AS cities2 ON distances.city2_id = cities2.id;

--функция
CREATE OR REPLACE FUNCTION update_distances()
RETURNS TRIGGER AS $$
DECLARE
    city1 int;
    city2 int;
	
    city1_coordinates POINT;
    city2_coordinates POINT;
	
	x_1 real;
	x_2 real;
	y_1 real;
	y_2 real;
	
	distance real;
BEGIN
    FOR city1 IN SELECT id FROM cities LOOP
        FOR city2 IN SELECT id FROM cities WHERE id <> city1 LOOP
            IF NOT EXISTS (
                SELECT 1 FROM distances 
                WHERE (distances.city1_id = city1 AND distances.city2_id = city2)
                OR (distances.city1_id = city2 AND distances.city2_id = city1)
            ) THEN
				RAISE NOTICE 'подсчет расстояния между городами % и %', city1, city2;
                SELECT coordinates INTO city1_coordinates FROM cities WHERE id = city1;
                SELECT coordinates INTO city2_coordinates FROM cities WHERE id = city2;
				x_1 = city1_coordinates[0];
				x_2 = city2_coordinates[0];
				y_1 = city1_coordinates[1];
				y_2 = city2_coordinates[1];
				distance := SQRT((x_1-x_2)*(x_1-x_2)+(y_1-y_2)*(y_1-y_2));
				
                INSERT INTO distances (city1_id, city2_id, distance)
                VALUES (city1, city2, distance);
            END IF;
        END LOOP;
    END LOOP;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

--тригер
CREATE OR REPLACE TRIGGER update_distances_trigger
AFTER INSERT OR UPDATE OR DELETE ON cities
FOR EACH ROW EXECUTE FUNCTION update_distances();