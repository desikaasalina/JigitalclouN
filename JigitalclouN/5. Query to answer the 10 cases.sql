--QUERIES

--1. Display StaffId, StaffName, StaffGender, StaffSalary, and LongestPeriod (obtained from the maximum amount of rental duration of the handled transactions) for every staff who have a salary less than 15000000 and have handled rental transactions with customers younger than 20 years old.
SELECT ms.StaffId, StaffName, StaffGender, StaffSalary, MAX(RentalDuration) as [LongestPeriod]
	FROM MsStaff ms
	JOIN RentalTransactionHeader rth 
	ON rth.StaffID = ms.StaffID
	JOIN RentalTransactionDetail rtd
	ON rtd.RentalTransactionID = rth.RentalTransactionID
	JOIN MsCustomer mc
	ON mc.CustomerID = rth.CustomerID
WHERE StaffSalary < 15000000 AND
YEAR(GETDATE()) - YEAR(CustomerDOB) < 20
GROUP BY ms.StaffID, StaffName, StaffGender, StaffSalary


--2. Display Location (obtained from LocationCityName, followed by a space and LocationCountryName), CheapestServerPrice (obtained from the ServerPriceIDR of the server with the lowest price located in each location) for every location that has a server using processor with clock speed faster than 3000 MHz. and is located at most 30 degrees from the equator (LocationLatitude must be at least -30 and at most 30).
SELECT CONCAT(LocationCity,' ',LocationCountry) as [Location], MIN(ServerPrice) AS [CheapestServerPrice]
	FROM MsLocation ml
	JOIN MsServer mv
	ON ml.LocationID = mv.LocationID
	JOIN MsProcessor mp
	ON mv.ProcessorID = mp.ProcessorID
WHERE ProcessorClockSpeed > 3000 AND LocationLatitude BETWEEN -30 AND 30
GROUP BY LocationCity,LocationCountry


--3. Display RentalID, MaxMemoryFrequency (obtained from the maximum MemoryFrequencyMHz followed by ' MHz'), TotalMemoryCapacity (obtained from the sum of MemoryCapacityGB followed by ' GB') for each rental transaction which occurs on the last quarter of 2020.
SELECT rth.RentalTransactionID AS [RentalID], (CAST(MAX(MemoryFrequency) AS VARCHAR) + ' MHz') AS [MaxMemoryFrequency],
(CAST(SUM(MemoryCapacity) AS VARCHAR) + ' GB') AS [TotalMemoryCapacity]
	FROM RentalTransactionHeader rth
	JOIN RentalTransactionDetail rtd 
	ON rth.RentalTransactionID = rtd.RentalTransactionID
	JOIN MsServer mv
	ON rtd.ServerID = mv.ServerID
	JOIN MsMemory mm
	ON mv.MemoryID = mm.MemoryID
WHERE YEAR(RentalStartDate) = 2020 AND DATEPART(QUARTER,RentalStartDate) = 4 
GROUP BY rth.RentalTransactionID


--4. Display SaleID, ServerCount (obtained from the number of servers in each transaction), AverageServerPrice (obtained from the average of ServerPriceIDR divided by 1000000 followed by ' million(s) IDR'), for each sale transaction occurring in 2016 until 2020 and has AverageServerPrice of more than 50000000.
SELECT sth.SalesTransactionID AS [SalesID] , COUNT(std.SERVERID) AS [ServerCount], CONCAT((AVG(ServerPrice)/1000000),' million(s) IDR') AS [AverageServerPrice]
FROM SalesTransactionHeader sth
	JOIN SalesTransactionDetail std
	ON sth.SalesTransactionID = std.SalesTransactionID
	JOIN MsServer mv
	ON std.ServerID = mv.ServerID
WHERE YEAR(SalesTransactionDate) BETWEEN 2016 AND 2020
GROUP BY sth.SalesTransactionID
HAVING AVG(ServerPrice) > 50000000


-- 5. Display SaleID, MostExpensiveServerPrice (obtained from the most expensive server price in the transaction), HardwareRatingIndex (obtained from ((0.55 * ProcessorClock * ProcessorCoreCount) + (MemoryFrequency * MemoryCapacityGB * 0.05)) / 143200) formatted to 3 decimal places) for the sale transactions which has server listed in the top 10 most expensive servers which occurs in odd years. (ALIAS SUBQUERY)
SELECT SaleID, MostExpensiveServerPrice, HardwareRatingIndex FROM (
	SELECT sth.SalesTransactionID AS [SaleID],
	MAX(tts.ServerPrice) AS [MostExpensiveServerPrice]
	FROM SalesTransactionHeader sth
	JOIN SalesTransactionDetail std 
	ON std.SalesTransactionID = sth.SalesTransactionID
	JOIN
		(
		SELECT TOP 10 mv.ServerID, ServerPrice 
		FROM MsServer mv
		ORDER BY ServerPrice DESC
		) AS tts 
	ON tts.ServerID = std.ServerID
	WHERE YEAR(SalesTransactionDate)%2 = 0	
	GROUP BY sth.SalesTransactionID
	) AS ttsD
INNER JOIN (
	SELECT sth.SalesTransactionID, ServerPrice,
	CAST(((0.55 * ProcessorClockSpeed * ProcessorCores) + (MemoryFrequency * MemoryCapacity * 0.05)) / 143200 as decimal(5, 3)) AS [HardwareRatingIndex]
	FROM SalesTransactionHeader sth
	JOIN SalesTransactionDetail std 
	ON std.SalesTransactionID = sth.SalesTransactionID
	JOIN MsServer mv 
	ON mv.ServerID = std.ServerID
	JOIN MsProcessor mp 
	ON mp.ProcessorID = mv.ProcessorID
	JOIN MsMemory mm 
	ON mm.MemoryID = mv.MemoryID
	) AS ats 
	ON ttsD.MostExpensiveServerPrice = ats.ServerPrice AND ttsD.SaleID = ats.SalesTransactionID


--6. Display ProcessorName (obtained from the first word of ProcessorName followed by a space and ProcessorModel), CoreCount (obtained from ProcessorCoreCount followed by ' core(s)', ProcessorPriceIDR for the most expensive processors among the ones having the same core count and is used in servers located in the northern hemisphere (LocationLatitude is starts from 0 up to 90). The result must not be duplicate. (ALIAS SUBQUERY)

SELECT CONCAT((SUBSTRING(ProcessorName,1,CHARINDEX(' ',ProcessorName)-1)),' ',ProcessorModelCode) AS [ProcessorName],CONCAT(ProcessorCores,' core(s)') AS [CoreCount], mp.ProcessorPrice AS [ProcessorPriceIDR]
FROM MsProcessor mp
	JOIN MsServer mv
	ON mp.ProcessorID = mv.ProcessorID
	JOIN MsLocation ml
	ON mv.LocationID = ml.LocationID,
	(SELECT MAX(ProcessorPrice) as MAXPRICE
		FROM MsProcessor
		GROUP BY ProcessorCores) SUB1
WHERE LocationLatitude BETWEEN 0 AND 90 AND ProcessorPrice = SUB1.MAXPRICE


--7. Display HiddenCustomerName (obtained from the first letter of CustomerName followed by '***** *****'), CurrentPurchaseAmount (obtained from the amount of sale transactions made), CountedPurchaseAmount (obtained from the amount of sale transactions made), RewardPointsGiven (obtained from the total spending (counted from the sum of ServerPriceIDR for all transactions made) of the customer divided by 1000000 followed by ' point(s)'), for each customer who is in the top 10 customer with most spending in server purchasing (sale transactions) in 2015 until 2019 period. (ALIAS SUBQUERY)
SELECT CONCAT(LEFT(CustomerName, 1), '***** *****') AS [HiddenCustomerName],
	TotalSpending AS [CurrentPurchaseAmount], 
	CountedPurchaseAmount,
	CONCAT((TotalSpending/1000000), ' point(s)') AS [RewardPointsGiven]
FROM MsCustomer mc
JOIN (
		SELECT TOP 10 CustomerID, COUNT(*) as [CountedPurchaseAmount], SUM(ServerPrice) as TotalSpending 
		FROM SalesTransactionHeader sth
		JOIN SalesTransactionDetail std 
		ON sth.SalesTransactionID = std.SalesTransactionID
		JOIN MsServer mv 
		ON mv.ServerID = std.ServerID
		WHERE YEAR(SalesTransactionDate) BETWEEN 2015 AND 2019
		GROUP BY CustomerID
		ORDER BY SUM(ServerPrice) DESC
	) as tc 
	ON tc.CustomerID = mc.CustomerID


--8. Display StaffName (obtained from 'Staff ' followed by the first word of StaffName), StaffEmail (obtained from replacing part after the '@' in StaffEmail with 'jigitalcloun.net'), StaffAddress, StaffSalary (obtained from StaffSalary divided by 10000000 followed by ' million(s) IDR'), TotalValue (obtained from the sum of (ServerPriceIDR / 120 * RentalDuration)) for every staff who have a salary below the average staff salary and has a TotalValue more than 10000000.(ALIAS SUBQUERY)
SELECT CONCAT('Staff ',(SUBSTRING(StaffName,1,CHARINDEX(' ',StaffName)))) AS [StaffName], STUFF(StaffEmail,CHARINDEX('@',StaffEmail)+1,LEN(StaffEmail)-CHARINDEX('@',StaffEmail),'jigitalcloun.net') AS [StaffEmail], StaffAddress, CONCAT(SUM(StaffSalary/10000000),' million(s) IDR') AS [StaffSalary], SUM(ServerPrice/120*RentalDuration) AS [TotalValue]
FROM MsStaff ms
	JOIN RentalTransactionHeader rth
	ON ms.StaffID = rth.StaffID
	JOIN RentalTransactionDetail rtd
	ON rth.RentalTransactionID = rtd.RentalTransactionID
	JOIN MsServer mv
	ON rtd.ServerID = mv.ServerID,
	(SELECT AVG(StaffSalary) AS AVGSALARY 
	FROM MsStaff) SUB1
GROUP BY StaffName,StaffEmail,StaffAddress,SUB1.AVGSALARY,StaffSalary
HAVING StaffSalary < SUB1.AVGSALARY AND SUM(ServerPrice/120*RentalDuration) > 10000000

--9. Create a view named ‘ServerRentalDurationView’ to display Server (obtained from Replacing 'JCN-V' in ServerID with 'No. '), TotalRentalDuration (Obtained from the total rental duration on the server followed by ' month(s)'), MaxSingleRentalDuration (Obtained from the maximum rental duration on the server followed by ' month(s)') for all servers located in the southern hemisphere (Latitude is below 0 down to -90) which have more than 50 months of total rental duration.
GO
CREATE VIEW [ServerRentalDurationView] AS
SELECT REPLACE(mv.ServerID, 'JCN-V', 'No. ') AS [Server],
CONCAT(SUM(RentalDuration), ' month(s)') AS [TotalRentalDuration],
CONCAT(MAX(RentalDuration), ' month(s)') AS [MaxSingleRentalDuration]
FROM MsServer mv
JOIN RentalTransactionDetail rtd 
ON rtd.ServerID = mv.ServerID
JOIN MsLocation ml
ON ml.LocationID = mv.LocationID
WHERE LocationLatitude > -90 AND LocationLatitude < 0
GROUP BY mv.ServerID
HAVING SUM(RentalDuration) > 50
GO


--10. Create a view named ‘SoldProcessorPerformanceView’ to display SaleID, MinEffectiveClock (obtained from the minimum value of ProcessorClockMHZ * ProcessorCoreCount * 0.675, displayed with 1 decimal places followed by ' MHz'), MaxEffectiveClock (obtained from the maximum value of ProcessorClockMHZ * ProcessorCoreCount * 0.675, displayed with 1 decimal places followed by ' MHz') for every rental transaction that rents a server using a processor with a core count of a power of 2 and that has a MinEffectiveClock of at least 10000.
GO
CREATE VIEW SoldProcessorPerformanceView
AS
SELECT sth.SalesTransactionID as [SaleID],
CONCAT(MIN(ROUND(ProcessorClockSpeed*ProcessorCores*0.675,1)), ' Mhz') AS [MinEffectiveClock], CONCAT(MAX(ROUND(ProcessorClockSpeed*ProcessorCores*0.675,1)), ' Mhz')AS [MaxEffectiveClock]
	FROM SalesTransactionHeader sth
	JOIN MsStaff ms
	ON sth.StaffID = ms.StaffID
	JOIN RentalTransactionHeader rth
	ON ms.StaffID = rth.StaffID
	JOIN RentalTransactionDetail rtd
	ON rth.RentalTransactionID = rtd.RentalTransactionID
	JOIN MsServer mv
	ON rtd.ServerID = mv.ServerID
	JOIN MsProcessor mp
	ON mv.ProcessorID = mp.ProcessorID
WHERE ProcessorCores IN ('1','2','4','8','16')
GROUP BY SalesTransactionID
HAVING MIN(ProcessorClockSpeed*ProcessorCores*0.675) >= 10000
GO