/******************************************************************************************************************
 * 1. Creating database and tables for TravelOnTheGo
 * 
 ******************************************************************************************************************/

CREATE DATABASE IF NOT EXISTS `TravelOnTheGo`;

CREATE TABLE IF NOT EXISTS `TravelOnTheGo`.PASSENGER (
	`Passenger_name` varchar(100) NOT NULL,
	`Category` varchar(100) NOT NULL,
	`Gender` varchar(20) NOT NULL,
	`Boarding_City` varchar(100) NOT NULL,
	`Destination_City` varchar(100) NOT NULL,
	`Distance` INT NOT NULL,
	`Bus_Type` varchar(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS `TravelOnTheGo`.PRICE (
	`Bus_Type` varchar(100) NOT NULL,
	`Distance` INT NOT NULL,
	`Price` INT NOT NULL
)̰



/******************************************************************************************************************
 * 
 * 2. Inserting data
 * 
 ******************************************************************************************************************/

INSERT
	INTO
	`TravelOnTheGo`.PASSENGER 
    (Passenger_name,
	Category,
	Gender,
	Boarding_City,
	Destination_City,
	Distance,
	Bus_Type)
VALUES 
	('Sejal',
'AC',
'F',
'Bengaluru',
'Chennai',
350,
'Sleeper'),
	('Anmol',
'Non-AC',
'M',
'Mumbai',
'Hyderabad',
700,
'Sitting'),
	('Pallavi',
'AC',
'F',
'Panaji',
'Bengaluru',
600,
'Sleeper'),
	('Khusboo',
'AC',
'F',
'Chennai',
'Mumbai',
1500,
'Sleeper'),
	('Udit',
'Non-AC',
'M',
'Trivandrum',
'Panaji',
1000,
'Sleeper'),
	('Ankur',
'AC',
'M',
'Nagpur',
'Hyderabad',
500,
'Sitting'),
	('Hemant',
'Non-AC',
'M',
'Panaji',
'Mumbai',
700,
'Sleeper'),
	('Manish',
'Non-AC',
'M',
'Hyderabad',
'Bengaluru',
500,
'Sitting'),
	('Piyush',
'AC',
'M',
'Pune',
'Nagpur',
700,
'Sitting')
	

INSERT
	INTO
	`TravelOnTheGo`.PRICE 
    (Bus_Type,
	Distance,
	Price)
VALUES 
	('Sleeper',
350,
770),
	('Sleeper',
500,
1100),
	('Sleeper',
600,
1320),
	('Sleeper',
700,
1540),
	('Sleeper',
1000,
2200),
	('Sleeper',
1200,
2650),
	('Sleeper',
350,
434),
	('Sitting',
500,
620),
	('Sitting',
500,
620),
	('Sitting',
600,
744),
	('Sitting',
700,
868),
	('Sitting',
1000,
1240),
	('Sitting',
1200,
1488),
	('Sitting',
1500,
1860)
	
	

	
/******************************************************************************************************************
 * 
 * Q3: How many females and how many male passengers travelled for a minimum distance of 600 KM s? 
 * 
 ******************************************************************************************************************/
	
SELECT
	Gender,
	count(Gender)
FROM
	`TravelOnTheGo`.PASSENGER
WHERE
	Distance >= 600
group by
	Gender;

/******************************************************************************************************************
 * 
 * Q4 Find the minimum ticket price for Sleeper Bus.
 * 
 ******************************************************************************************************************/

SELECT
	min(price)
FROM
	`TravelOnTheGo`.PRICE p
WHERE
	Bus_Type = 'Sleeper';

/******************************************************************************************************************
 * 
 * Q5 Select passenger names whose names start with character 'S'
 * 
 ******************************************************************************************************************/

SELECT
	*
FROM
	`TravelOnTheGo`.PASSENGER p
WHERE
	Passenger_name like 'S%';

/******************************************************************************************************************
 * 
 * Q6  Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output
 * 
 ******************************************************************************************************************/

SELECT 
	P.Passenger_name,
	P.Boarding_City,
	P.Boarding_City,
	P.Bus_Type ,
	Pr.Price AS price
FROM
	TravelOnTheGo.PASSENGER P
INNER JOIN PRICE Pr ON
	P.Bus_Type = Pr.Bus_Type
	AND P.Distance = Pr.Distance
GROUP BY
	P.Passenger_name ;

/******************************************************************************************************************
 * 
 * Q7 What is the passenger name and his/her ticket price who travelled in Sitting bus for a
distance of 1000 KM s
 * 
 ******************************************************************************************************************/

SELECT 
	P.Passenger_name,
	Pr.Price 
FROM
	TravelOnTheGo.PASSENGER P
INNER JOIN TravelOnTheGo.PRICE Pr ON
	P.Bus_Type = Pr.Bus_Type 
	AND P.Distance = Pr.Distance 
WHERE
	P.Bus_Type = 'Sitting'
	AND P.Distance = 1000;



/******************************************************************************************************************
 * 
 * Q8 What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?
 * 
 ******************************************************************************************************************/

SELECT
	Pr.Bus_Type ,
	Pr.Price
FROM
	TravelOnTheGo.PASSENGER P,
	TravelOnTheGo.PRICE Pr
WHERE 
	P.Passenger_name = 'Pallavi'
	AND P.Distance = Pr.Distance ;

/******************************************************************************************************************
 * 
 * Q9 List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order.
 * 
 ******************************************************************************************************************/
	
SELECT
	DISTINCT Distance
FROM
	TravelOnTheGo.PASSENGER
ORDER BY
	Distance DESC;

/******************************************************************************************************************
 * 
 * Q10 Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables
 * 
 ******************************************************************************************************************/
	
SELECT
	Passenger_name,
	(Distance /(
	SELECT
		SUM(Distance)
	FROM
		TravelOnTheGo.PASSENGER) * 100) as Percentage_of_Distance_travelled
FROM
	TravelOnTheGo.PASSENGER;

/******************************************************************************************************************
 * 
 * Q11 Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
 * 
 ******************************************************************************************************************/

SELECT
	Distance ,
	Price ,
	CASE
		WHEN Price > 1000 THEN 'Expensive'
		WHEN Price <= 1000
		AND Price > 500 THEN 'Average Cost'
		ELSE 'Cheap'
	END AS price_category
FROM
	TravelOnTheGo.PRICE;
