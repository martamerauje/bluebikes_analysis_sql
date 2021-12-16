-- BlueBikes Analysis from 2016-2019

-- Popular Stations based on start_time and year
	
SELECT *
	-- using DATE_PART funtion to filter year part in the start_time column and make a new column called 'year' for output
FROM(SELECT DATE_PART ('year', start_time) as year,
	-- list the columns for of the desired output
		bikes.start_station_id, 
		stations.name,
		stations.district, 
		stations.total_docks,
	-- use count funtion to count how many times a particular station id appear in start_time in 2016
		COUNT (bikes.start_time) as starting_time,
	-- sorting the row from the largest to smallest count of start time
	 	ROW_NUMBER () OVER (ORDER BY (COUNT (bikes.start_time)) DESC)
FROM bluebikes_2016 as bikes
	-- join bluebikes_2016 and bluebikes_stations
JOIN bluebikes_stations as stations
	-- joining based on primary keys
ON bikes.start_station_id = stations.id
GROUP BY 1,2,3,4,5
ORDER BY 6 DESC) x
	-- limit output where row number is equal to or less than 5
WHERE ROW_NUMBER <= 5

	-- repeat the same query for bluebikes_2017, bluebikes_2018, bluebikes_2019 data 
	-- Join each ear using UNION function

UNION
SELECT *
FROM(SELECT DATE_PART ('year', start_time) as year,
		bikes.start_station_id, 
		stations.name,
		stations.district, 
		stations.total_docks,
		COUNT (bikes.start_time) as starting_time,
		ROW_NUMBER () OVER (ORDER BY (COUNT (bikes.start_time)) DESC)
FROM bluebikes_2017 as bikes
JOIN bluebikes_stations as stations
ON bikes.start_station_id = stations.id
GROUP BY 1,2,3,4,5
ORDER BY 6 DESC) x
WHERE ROW_NUMBER <= 5 -- using Where filter the rows
UNION
SELECT *
FROM(SELECT DATE_PART ('year', start_time) as year,
		bikes.start_station_id, 
		stations.name,
		stations.district, 
		stations.total_docks,
	-- use count funtion to count how many times a particular station id appear in start_time in 2016
		COUNT (bikes.start_time) as starting_time,
	-- sorting the row from the largest to smallest count of start time
	 	ROW_NUMBER () OVER (ORDER BY (COUNT (bikes.start_time)) DESC)
FROM bluebikes_2018 as bikes
	-- join bluebikes_2016 and bluebikes_stations
JOIN bluebikes_stations as stations
	-- joining based on primary keys
ON bikes.start_station_id = stations.id
GROUP BY 1,2,3,4,5
ORDER BY 6 DESC) x
	-- limit output where row number is equal to or less than 5
WHERE ROW_NUMBER <= 5
UNION
SELECT *
FROM(SELECT DATE_PART ('year', start_time) as year,
		bikes.start_station_id, 
		stations.name,
		stations.district, 
		stations.total_docks,
		COUNT (bikes.start_time) as starting_time,
	 	ROW_NUMBER () OVER (ORDER BY (COUNT (bikes.start_time)) DESC)
FROM bluebikes_2019 as bikes
JOIN bluebikes_stations as stations
ON bikes.start_station_id = stations.id
GROUP BY 1,2,3,4,5
ORDER BY 6 DESC) x
WHERE ROW_NUMBER <= 5;

-- 5 Popular Stations based on end time and year

SELECT *
	-- using DATE_PART funtion to filter year part in the end_time column and make a new column called 'year' for output
FROM(SELECT DATE_PART ('year', end_time) as year,
	-- list the columns for of the desired output
		bikes.end_station_id, 
		stations.name,
		stations.district, 
		stations.total_docks,
		COUNT (bikes.end_time) as ending_time,
	 	ROW_NUMBER () OVER (ORDER BY (COUNT (bikes.end_time)) DESC)
FROM bluebikes_2016 as bikes
JOIN bluebikes_stations as stations
ON bikes.end_station_id = stations.id
GROUP BY 1,2,3,4,5
ORDER BY 6 DESC) x
WHERE ROW_NUMBER <= 5
UNION
SELECT *
FROM(SELECT DATE_PART ('year', end_time) as year,
		bikes.end_station_id, 
		stations.name,
		stations.district, 
		stations.total_docks,
		COUNT (bikes.end_time) as ending_time,
	 	ROW_NUMBER () OVER (ORDER BY (COUNT (bikes.end_time)) DESC)
FROM bluebikes_2017 as bikes
JOIN bluebikes_stations as stations
ON bikes.end_station_id = stations.id
GROUP BY 1,2,3,4,5
ORDER BY 6 DESC) x
WHERE ROW_NUMBER <= 5

	-- repeat the same query for bluebikes_2017, bluebikes_2018, bluebikes_2019 data 
	-- Join each ear using UNION function

UNION
SELECT *
FROM(SELECT DATE_PART ('year', end_time) as year,
		bikes.end_station_id, 
		stations.name,
		stations.district, 
		stations.total_docks,
		COUNT (bikes.end_time) as ending_time,
	 	ROW_NUMBER () OVER (ORDER BY (COUNT (bikes.end_time)) DESC)
FROM bluebikes_2018 as bikes
JOIN bluebikes_stations as stations
ON bikes.end_station_id = stations.id
GROUP BY 1,2,3,4,5
ORDER BY 6 DESC) x
WHERE ROW_NUMBER <= 5
UNION
SELECT *
FROM(SELECT DATE_PART ('year', end_time) as year,
		bikes.end_station_id, 
		stations.name,
		stations.district, 
		stations.total_docks,
		COUNT (bikes.end_time) as endinging_time,
	 	ROW_NUMBER () OVER (ORDER BY (COUNT (bikes.end_time)) DESC)
FROM bluebikes_2019 as bikes
JOIN bluebikes_stations as stations
ON bikes.end_station_id = stations.id
GROUP BY 1,2,3,4,5
ORDER BY 6 DESC) x
WHERE ROW_NUMBER <= 5;

-- user growth over year by user_type and year

SELECT DATE_PART('year', start_time), user_type, 
		COUNT(bike_id) as bike_usage 
FROM public.bluebikes_2016
WHERE bike_id IS NOT NULL
GROUP BY 1,2
UNION ALL
SELECT DATE_PART ('year', start_time), user_type,
		COUNT(bike_id) as bike_usage
FROM public.bluebikes_2017
WHERE bike_id IS NOT NULL
GROUP BY 1,2
UNION ALL
SELECT DATE_PART ('year', start_time), user_type,
		COUNT(bike_id) as bike_usage 
FROM public.bluebikes_2018
WHERE bike_id IS NOT NULL
GROUP BY 1,2
UNION ALL
SELECT DATE_PART ('year', start_time), user_type,
		COUNT(bike_id) as bike_usage 
FROM public.bluebikes_2019
WHERE bike_id IS NOT NULL
GROUP BY 1,2
ORDER BY 1
;

-- average duration by user_type and year

	-- Using DATE_PART funtion to filter year part in the start_time column and make a new column called 'user_type' for output
SELECT DATE_PART ('year', start_time) as year, user_type,
	-- count average of duration and make new column called 'avg_duration' for output
		AVG (AGE (end_time, start_time)) as avg_duration
FROM bluebikes_2016
	-- grouping by year and average duration
GROUP BY 1,2

	-- repeat the same query for bluebikes_2017, bluebikes_2018, bluebikes_2019 data 
	-- Join each ear using UNION function

UNION
SELECT DATE_PART ('year', start_time) as year, user_type,
		AVG (AGE (end_time, start_time)) as avg_duration
FROM bluebikes_2017
GROUP BY 1,2
UNION
SELECT DATE_PART ('year', start_time) as year, user_type,
		AVG (AGE (end_time, start_time)) as avg_duration
FROM bluebikes_2018
GROUP BY 1,2
UNION
SELECT DATE_PART ('year', start_time) as year, user_type,
		AVG (AGE (end_time, start_time)) as avg_duration
FROM bluebikes_2019
GROUP BY 1,2
ORDER BY 1;

-- Total usage based on age group and year
	-- using DATE_PART funtion to filter year part in the start_time column and make a new column called 'year' for output
SELECT DATE_PART ('year', start_time) as year,
	-- make a case statement to group output in new groups
CASE
		WHEN user_birth_year >= '1994' THEN 'Gen Z'
		WHEN user_birth_year >= '1980' THEN 'Millenials'
		WHEN user_birth_year >= '1975' THEN 'Xennials'
		ELSE 'Baby Boomers'
	-- create a new cloumn for output of the case statement
	-- count all the output based on each group and put them in new group
		END as user_age_group, COUNT (*) as total
FROM bluebikes_2016
GROUP BY 1,2

	-- repeat the same query for bluebikes_2017, bluebikes_2018, bluebikes_2019 data 
	-- Join each ear using UNION function

UNION
SELECT DATE_PART ('year', start_time) as year,
CASE
		WHEN user_birth_year >= '1994' THEN 'Gen Z'
		WHEN user_birth_year >= '1980' THEN 'Millenials'
		WHEN user_birth_year >= '1975' THEN 'Xennials'
		ELSE 'Baby Boomers'
		END as user_age_group, COUNT (*) as total
FROM bluebikes_2017
GROUP BY 1,2
UNION
SELECT DATE_PART ('year', start_time) as year,
CASE
		WHEN user_birth_year >= '1994' THEN 'Gen Z'
		WHEN user_birth_year >= '1980' THEN 'Millenials'
		WHEN user_birth_year >= '1975' THEN 'Xennials'
		ELSE 'Baby Boomers'
		END as user_age_group, COUNT (*) as total
FROM bluebikes_2018
GROUP BY 1,2
UNION
SELECT DATE_PART ('year', start_time) as year,
CASE
		WHEN user_birth_year >= '1994' THEN 'Gen Z'
		WHEN user_birth_year >= '1980' THEN 'Millenials'
		WHEN user_birth_year >= '1975' THEN 'Xennials'
		ELSE 'Baby Boomers'
		END as user_age_group, COUNT (*) as total
FROM bluebikes_2019
GROUP BY 1,2
ORDER BY 1,3 DESC;

-- Average duration based on user age group and year
	-- using DATE_PART funtion to filter year part in the start_time column and make a new column called 'year' for output
SELECT DATE_PART ('year', start_time) as year,
	-- make a case statement to group output in new groups
CASE
		WHEN user_birth_year >= '1994' THEN 'Gen Z'
		WHEN user_birth_year >= '1980' THEN 'Millenials'
		WHEN user_birth_year >= '1975' THEN 'Xennials'
		ELSE 'Baby Boomers'
	-- create a new cloumn for output of the case statement
	-- count all the output based on each group and put them in new group
		END as user_age_group, COUNT (*) as total,
	-- count duration time of each group
		AVG (AGE (end_time, start_time)) as avg_duration
FROM bluebikes_2016
GROUP BY 1,2

	-- repeat the same query for bluebikes_2017, bluebikes_2018, bluebikes_2019 data 
	-- Join each ear using UNION function

UNION
SELECT DATE_PART ('year', start_time) as year,
CASE
		WHEN user_birth_year >= '1994' THEN 'Gen Z'
		WHEN user_birth_year >= '1980' THEN 'Millenials'
		WHEN user_birth_year >= '1975' THEN 'Xennials'
		ELSE 'Baby Boomers'
		END as user_age_group, COUNT (*) as total,
		AVG (AGE (end_time, start_time)) as avg_duration
FROM bluebikes_2017
GROUP BY 1,2
UNION
SELECT DATE_PART ('year', start_time) as year,
CASE
		WHEN user_birth_year >= '1994' THEN 'Gen Z'
		WHEN user_birth_year >= '1980' THEN 'Millenials'
		WHEN user_birth_year >= '1975' THEN 'Xennials'
		ELSE 'Baby Boomers'
		END as user_age_group, COUNT (*) as total,
		AVG (AGE (end_time, start_time)) as avg_duration
FROM bluebikes_2018
GROUP BY 1,2
UNION
SELECT DATE_PART ('year', start_time) as year,
CASE
		WHEN user_birth_year >= '1994' THEN 'Gen Z'
		WHEN user_birth_year >= '1980' THEN 'Millenials'
		WHEN user_birth_year >= '1975' THEN 'Xennials'
		ELSE 'Baby Boomers'
		END as user_age_group, COUNT (*) as total,
		AVG (AGE (end_time, start_time)) as avg_duration
FROM bluebikes_2019
GROUP BY 1,2
ORDER BY 1,4 DESC;

-- average duartion by gender and year

	-- gender specified 1=male, 2=female, 0=n/a answer
	-- using DATE_PART funtion to filter year part in the start_time column and make a new column called 'year' for output
SELECT DATE_PART ('year', start_time) as year, 
	-- count the average duration of usage and make a new column for output called 'avg_duration'
	-- select user_gender column
		AVG (AGE (end_time, start_time)) as avg_duration, user_gender,
	-- rename binary output into String name
		CASE WHEN user_gender = 2 THEN 'Male'
		WHEN user_gender = 1 THEN 'Female'
		ELSE 'N/a'
END as gender_group
FROM bluebikes_2016
GROUP BY 1,3

	-- repeat the same query for bluebikes_2017, bluebikes_2018, bluebikes_2019 data 
	-- Join each ear using UNION function

UNION
SELECT DATE_PART ('year', start_time) as year, 
		AVG (AGE (end_time, start_time)) as avg_duration,
		user_gender, 
		CASE WHEN user_gender = 2 THEN 'Male'
		WHEN user_gender = 1 THEN 'Female'
		ELSE 'N/a'
END as gender_group
FROM bluebikes_2017
GROUP BY 1,3
UNION
SELECT DATE_PART ('year', start_time) as year, 
		AVG (AGE (end_time, start_time)) as avg_duration,
		user_gender, 
		CASE WHEN user_gender = 2 THEN 'Male'
		WHEN user_gender = 1 THEN 'Female'
		ELSE 'N/a'
END as gender_group
FROM bluebikes_2018
GROUP BY 1,3
UNION
SELECT DATE_PART ('year', start_time) as year, 
		AVG (AGE (end_time, start_time)) as avg_duration,
		user_gender, 
		CASE WHEN user_gender = 2 THEN 'Male'
		WHEN user_gender = 1 THEN 'Female'
		ELSE 'N/a'
END as gender_group
FROM bluebikes_2019
GROUP BY 1,3
ORDER BY 1;


