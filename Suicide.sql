SELECT * FROM project_intermediate.suicide;

##Sorting the table based on total number of suicide in each generation which will be later used for data visualisation
SELECT ï»¿country, year, SUM(suicides_no), generation
FROM suicide
WHERE ï»¿country = 'South Africa'
GROUP BY generation
Order By generation DESC;

##Narrow the table data to millenials (Young adults) in South Africa, both male and female
SELECT distinct ï»¿country, year, age, suicides_no 
FROM suicide
WHERE generation = 'Millenials' 
AND ï»¿country = 'South Africa'
AND age =  '15-24 years'
GROUP BY year;

SELECT * 
FROM happiness
WHERE Country = 'South Africa';

##Trying to analyse if suicide is closely linked to happiness of a country

SELECT ï»¿country
FROM project_intermediate.suicide
WHERE ï»¿country = 'Switzerland';

SELECT ï»¿country, year, SUM(suicides_no), generation
FROM suicide
WHERE ï»¿country = 'Switzerland'
GROUP BY generation
Order By generation DESC;

SELECT ï»¿country, year, SUM(suicides_no), generation
FROM suicide
WHERE ï»¿country = 'South Africa'
GROUP BY generation
Order By generation DESC;

##Renaming Suicide ï»¿country column to Country, to make Joining Suicide and Happiness table possible

ALTER TABLE suicide 
RENAME COLUMN ï»¿country TO Country;

##Joining Tables
##Comparing SA with Switzerland the happiest ranking country, if suicide cases are linked to the economy of the country

SELECT s.Country, s.year, s.suicides_no, s.generation, h.`Happiness Rank`, h.`Economy (GDP per Capita)`
FROM suicide s
JOIN happiness h ON s.Country = h.Country
WHERE h.Country = 'South Africa'
GROUP BY year;

SELECT s.Country, year, s.suicides_no, h.`Happiness Rank`, h.`Economy (GDP per Capita)`
FROM suicide s
LEFT JOIN happiness h ON s.Country = h.Country
WHERE s.Country = 'South Africa' OR
s.Country = 'Switzerland'
GROUP BY year;

##Data Exploring the Happinness dataset

SELECT * 
FROM happiness;

##Comparison between BRICS countries
SELECT Country, `Happiness Rank`, `Economy (GDP per Capita)`, `Trust (Government Corruption)`
FROM happiness
WHERE Country = 'Brazil' OR
Country = 'Russia' OR
Country = 'India' OR
Country = 'China' OR
Country = 'South Africa'
GROUP BY Country
ORDER BY `Happiness Rank` ASC;

##using CTE to calculate average GDP of the economy globally, then use CASE statement
WITH Avg_gdp AS 
(SELECT AVG(`Economy (GDP per Capita)`) AS avg_gdp
FROM happiness)
SELECT
h.Country, h.`Happiness Rank`, h.`Economy (GDP per Capita)`, h.`Trust (Government Corruption)`, Avg_gdp,
CASE WHEN AVG(`Economy (GDP per Capita)`) >= 3.15669 THEN 'above average' ELSE 'below average' END AS countries_condition
FROM happiness h
JOIN AVG_GDP a 
GROUP BY Country
ORDER BY `Happiness Rank` ASC;

##using CTE to calculate average GDP of the economy globally vs BRICS Countries, then use CASE statement
WITH Avg_gdp AS 
(SELECT AVG(`Economy (GDP per Capita)`) AS Avg_gdp
FROM happiness)
SELECT
h.Country, h.`Happiness Rank`, h.`Economy (GDP per Capita)`, h.`Trust (Government Corruption)`, Avg_gdp,
CASE WHEN AVG(`Economy (GDP per Capita)`) >= 3.15669 THEN 'above average' ELSE 'below average' END AS countries_condition
FROM happiness h
JOIN AVG_GDP a 
WHERE Country = 'Brazil' OR
Country = 'Russia' OR
Country = 'India' OR
Country = 'China' OR
Country = 'South Africa'
GROUP BY Country
ORDER BY `Happiness Rank` ASC;


SELECT Country, `Happiness Rank`, `Economy (GDP per Capita)`, `Health (Life Expectancy)`,
CASE 
	WHEN `Economy (GDP per Capita)` >= 1.20000 THEN 'The country is stable'
ELSE 'The country unstable'
END AS condition_country
FROM happiness
##WHERE Country = 'South Africa'
GROUP BY Country;

















