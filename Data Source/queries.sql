/* Query to get all stations in California **/ 
SELECT id, latitude, longitude, state, name
FROM `bigquery-public-data.ghcn_d.ghcnd_stations` 
WHERE state = 'CA'

-------
/* Query to get min max temps in 2019 **/
with california as (
SELECT id, latitude, longitude, state, name
FROM `bigquery-public-data.ghcn_d.ghcnd_stations` 
WHERE state = 'CA'
)

SELECT name, date, MAX(tmin) as minTemp, MAX(tmax) as maxTemp
FROM (
SELECT date, c.id AS id, c.name as name, 
       IF (wx.element = 'TMIN', wx.value/10, NULL) AS tmin,
       IF (wx.element = 'TMAX', wx.value/10, NULL) AS tmax, 
FROM california c, bigquery-public-data.ghcn_d.ghcnd_2019 wx
WHERE c.id = wx.id 
)
GROUP BY name, date
ORDER BY name, date
