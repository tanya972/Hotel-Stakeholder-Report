with hotels as (
SELECT TOP 1000 * FROM dbo.['2018$']
UNION 
SELECT TOP 1000 * FROM dbo.['2019$']
UNION 
SELECT TOP 1000 * FROM dbo.['2020$']
), 

all_info as (
	SELECT h.* from hotels h
	LEFT JOIN dbo.market_seg m 
	ON h.market_segment = m.market_segment
	LEFT JOIN dbo.meal_cost$ c
	ON c.meal = h.meal
)
SELECT * from all_info;

-- Is Revenue increasing every year? 
SELECT arrival_date_year, 
hotel, 
ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights)*adr),2) FROM all_info
GROUP BY arrival_date_year, hotel;
-- adr is rate per night */ 


--Correlation between length of stay and arrival date
SELECT SUM(stays_in_weekend_nights + stays_in_week_nights), dbo.arrival_date 
FROM all_info;



--Is number of guests increasing?
SELECT YEAR(reservation_status_date) as 'Year', SUM(adults + babies + children) AS 'Total Guests', hotel
FROM all_info
GROUP BY hotel, YEAR(reservation_status_date);







