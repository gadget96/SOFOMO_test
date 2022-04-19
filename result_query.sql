-- Przygotowanie danych do pracy
-- CREATE TABLE table_a (dimension_1 char, dimension_2 char, domension_3 char, measure_1 int);
-- CREATE TABLE table_b (dimension_1 char, dimension_2 char, measure_2 int);
-- CREATE TABLE map (dimension_1 char, correct_dimension_2 char);
-- INSERT INTO table_a VALUES ('a', 'I', 'K', 1);
-- INSERT INTO table_a VALUES ('a', 'J', 'L', 7);
-- INSERT INTO table_a VALUES ('b', 'I', 'M', 2);
-- INSERT INTO table_a VALUES ('c', 'J', 'N', 5);
-- INSERT INTO table_b VALUES ('a', 'J', 7);
-- INSERT INTO table_b VALUES ('b', 'J', 10);
-- INSERT INTO table_b VALUES ('d', 'J', 4);
-- INSERT INTO map VALUES ('a', 'W');
-- INSERT INTO map VALUES ('a', 'W');
-- INSERT INTO map VALUES ('b', 'X');
-- INSERT INTO map VALUES ('c', 'Y');
-- INSERT INTO map VALUES ('b', 'X');
-- INSERT INTO map VALUES ('d', 'Z');
-- SELECT * FROM table_a;
-- SELECT * FROM table_b;
-- SELECT * FROM map;

-- Finalne zapytanie rozwiązujące problem
WITH res_join AS (
	SELECT
		tba.dimension_1, 
		tba.measure_1, 
        tbb.measure_2
	FROM table_a tba
	LEFT JOIN
		table_b tbb ON tbb.dimension_1 = tba.dimension_1 
	
	UNION
    
	SELECT
		tbb.dimension_1, 
		tba.measure_1, 
        tbb.measure_2
	FROM table_b tbb
	LEFT JOIN
		table_a tba ON tbb.dimension_1 = tba.dimension_1 
	)
SELECT DISTINCT
	rj.dimension_1, 
    m.correct_dimension_2 AS dimension_2, 
    IFNULL(rj.measure_1, 0) AS measure_1,
    IFNULL(rj.measure_2, 0) AS measure_2 -- w moim przypadku użwyałem MySQL'a gdzie nie ma fukncji NVL, musiałem wykorzystać IFNULL
FROM res_join rj
JOIN map m ON m.dimension_1 = rj.dimension_1
;