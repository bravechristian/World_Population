USE population;

--Creating table
IF OBJECT_ID('countries') IS NOT NULL DROP TABLE countries

CREATE TABLE countries (
	rank_id INT
	,code VARCHAR(50)
	,country VARCHAR(225)
	,capital VARCHAR(225)
	,continent VARCHAR(225)
	,population_2022 BIGINT
	,population_2020 BIGINT
	,population_2015 BIGINT
	,population_2010 BIGINT
	,population_2000 BIGINT
	,population_1990 BIGINT
	,population_1980 BIGINT
	,population_1970 BIGINT
	,area INT
	,density_area FLOAT
	,growth_rate FLOAT
	,world_population_percent FLOAT
	
);


BULK INSERT countries
FROM 'C:\Users\camuh\Desktop\Datasets For Analysis\world_population.csv'
WITH (FORMAT = 'CSV');


SELECT * FROM countries ORDER BY country;

--Selecting Nigeria as a country for analysis
SELECT * FROM countries 
WHERE country = 'Nigeria';


SELECT
	country
	,population_2022
	,population_2020
	,(population_2022 - population_2020) AS growth_2022_2020
FROM countries WHERE country ='Nigeria';


--Showing results for population change across Africa since 1970
SELECT
	continent
	,(population_2022 - population_2020) AS growth_2022_2020
	,(population_2020 - population_2015) AS growth_2020_2015
	,(population_2015 - population_2010) AS growth_2015_2010
	,(population_2010 - population_2000) AS growth_2010_2000
	,(population_2000 - population_1990) AS growth_2000_1990
	,(population_1990 - population_1980) AS growth_1990_1980
	,(population_1980 - population_1970) AS growth_1980_1970
	,area
	,density_area
	,growth_rate
FROM countries WHERE continent ='Africa';


--showing result for the country with the highest population

SELECT * 
FROM countries 
		WHERE population_2022 =
		(SELECT MAX(population_2022)
		FROM countries)
ORDER BY country;

--Showing results for the three countries with the highest population

SELECT TOP 3 *
FROM countries 
ORDER BY population_2022 DESC;

--showing results for Africa's population

SELECT * FROM countries
WHERE continent = 'Africa';

SELECT 
	country
	,capital
	,population_2022
FROM countries WHERE continent = 'Africa'
ORDER BY population_2022 DESC;


--showing results for the total population in Africa

SELECT 
	continent
	,SUM(population_2022) AS Africa_population
FROM countries WHERE continent = 'Africa' GROUP BY continent;



--showing result for the world population by adding the current population of the entire world

SELECT 
	SUM(population_2022) AS world_population
FROM countries;

--Showing result for population of the different continent

SELECT
	continent
	,SUM(population_2022) AS population_per_continent
FROM countries GROUP BY continent;

--SELECT * FROM countries;


--showing results for continent population in relation to their land mass 

SELECT
	continent
	,SUM(population_2022) AS population_per_continent
	,SUM(area) AS land_mass
FROM countries 
GROUP BY continent;



--showing results from the ratio of population to land mass

SELECT
	continent
	,SUM(population_2022) AS population_per_continent
	,SUM(area) AS land_mass
	,(SUM(population_2022) / SUM(area)) AS ratio_pop_landmass
FROM countries 
GROUP BY continent;


SELECT * FROM countries;

--Creating views for the total population of each continent

CREATE VIEW population_continent AS
SELECT
	continent
	,SUM(population_2022) AS population_per_continent
	,SUM(area) AS land_mass
	,(SUM(population_2022) / SUM(area)) AS ratio_pop_landmass
FROM countries 
GROUP BY continent;

SELECT * FROM population_continent;


--Creating view for population change across Africa
CREATE VIEW population_change_africa AS
SELECT
	continent
	,(population_2022 - population_2020) AS growth_2022_2020
	,(population_2020 - population_2015) AS growth_2020_2015
	,(population_2015 - population_2010) AS growth_2015_2010
	,(population_2010 - population_2000) AS growth_2010_2000
	,(population_2000 - population_1990) AS growth_2000_1990
	,(population_1990 - population_1980) AS growth_1990_1980
	,(population_1980 - population_1970) AS growth_1980_1970
	,area
	,density_area
	,growth_rate
FROM countries WHERE continent ='Africa';

SELECT * FROM population_change_africa;


--Showing population in percentage

SELECT
	country
	,(population_2022 - population_2020) AS growth_2022_2020
	,((population_2022 - population_2020) / population_2022) * 100 AS percentage_change
FROM countries WHERE continent ='Africa';

--Creating views for percentage change
CREATE VIEW percentage_change AS
SELECT
	country
	,(population_2022 - population_2020) AS growth_2022_2020
	,((population_2022 - population_2020) / population_2022) * 100 AS percentage_change
FROM countries WHERE continent ='Africa';


SELECT * FROM percentage_change;