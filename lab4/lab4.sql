EXPLAIN ANALYZE SELECT Н_ЛЮДИ.ФАМИЛИЯ, Н_СЕССИЯ.ДАТА 
FROM Н_ЛЮДИ RIGHT JOIN Н_СЕССИЯ ON Н_ЛЮДИ.ИД = Н_СЕССИЯ.ЧЛВК_ИД
WHERE Н_ЛЮДИ.ИМЯ = 'Владимир' AND Н_СЕССИЯ.ЧЛВК_ИД > 106059;
--ни одного владимира с ид больше 106059 нету

EXPLAIN ANALYZE SELECT Н_ЛЮДИ.ИД, Н_ОБУЧЕНИЯ.НЗК, Н_УЧЕНИКИ.ИД
FROM Н_ЛЮДИ LEFT JOIN Н_УЧЕНИКИ ON Н_ЛЮДИ.ИД = Н_УЧЕНИКИ.ЧЛВК_ИД
LEFT JOIN Н_ОБУЧЕНИЯ ON Н_ЛЮДИ.ИД = Н_ОБУЧЕНИЯ.ЧЛВК_ИД
WHERE Н_ЛЮДИ.ИД > 152862 AND Н_ОБУЧЕНИЯ.НЗК::int < 001000;

SELECT * FROM Н_ОБУЧЕНИЯ;