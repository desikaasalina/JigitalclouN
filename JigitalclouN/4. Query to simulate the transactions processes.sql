-- SIMLUATION OF TRANSACTION PROCESSES USING DML


--1
--New Customer named Aryanto Andri wants to rent a server on 11 February 2021 for 3 years and needs to fill in their information such as ID, Name, Gender, email, Date of Birth, Phone Number, and Address.
INSERT INTO MSCustomer VALUES
('JCN-C3206','Aryanto Andri','Male', 'drindan@yahoo.com','2001/03/22','085866563324','19 Peleburan Raya')

--The transaction is served by Ajeng Astuti,the staff needs to fill in the data for Rental Transaction such as RentalTransaction ID, Staff ID, Customer ID, Rental Start Date, Server ID, and Rental Duration (In Months).
INSERT INTO RentalTransactionHeader VALUES
('JCN-R1260','JCN-S4285','JCN-C3206','2021/02/11')
INSERT INTO RentalTransactionDetail VALUES
('JCN-R1260','JCN-V5127','36')

-- After that, the staff will provide an invoice to the customer containing information on the transaction made
SELECT CustomerName, mc.CustomerID, StaffName, ms.StaffID, rth.RentalTransactionID, RentalStartDate, RentalDuration, rtd.ServerID, ServerPrice, SUM(ServerPrice/12*RentalDuration) AS TotalPrice
	FROM MsCustomer mc
	JOIN RentalTransactionHeader rth
	ON mc.CustomerID = rth.CustomerID
	JOIN MsStaff ms
	ON ms.StaffID = rth.StaffID
	JOIN RentalTransactionDetail rtd
	ON rth.RentalTransactionID = rtd.RentalTransactionID
	JOIN MsServer mv
	ON rtd.ServerID = mv.ServerID
WHERE rth.RentalTransactionID IN ('JCN-R1260')
GROUP BY CustomerName, mc.CustomerID, StaffName, ms.StaffID, rth.RentalTransactionID, RentalStartDate,RentalDuration, rtd.ServerID, ServerPrice
--The transaction has been completed



--2
--New Customer named Ineke Haryani wants to buy hardware on 22 January 2023 and needs to fill in their information such as ID, Name, Gender, email, Date of Birth, Phone Number, and Address.
INSERT INTO MSCustomer VALUES
('JCN-C3211','Ineke Haryani','Female','yan1@gmail.com','2003/12/01', '085766489930','124 Medokan Lama')

--The transaction is served by Jeremy Toruan ,the staff needs to fill in the data for Sales Transaction such as SalesTransaction ID, Staff ID, Customer ID, SalesTransaction Date, and Server ID.
INSERT INTO SalesTransactionHeader VALUES
('JCN-S1130','JCN-S4292','JCN-C3211','2023/01/22')
INSERT INTO SalesTransactionDetail VALUES
('JCN-S1130','JCN-V5133')

-- After that, the staff will provide an invoice to the customer containing information on the transaction made
SELECT CustomerName, mc.CustomerID, StaffName, ms.StaffID, sth.SalesTransactionID, SalesTransactionDate, std.ServerID, ServerPrice, SUM(ServerPrice) AS TotalPrice
	FROM MsCustomer mc
	JOIN SalesTransactionHeader sth
	ON mc.CustomerID = sth.CustomerID
	JOIN MsStaff ms
	ON ms.StaffID = sth.StaffID
	JOIN SalesTransactionDetail std
	ON sth.SalesTransactionID = std.SalesTransactionID
	JOIN MsServer mv
	ON std.ServerID = mv.ServerID
WHERE sth.SalesTransactionID IN ('JCN-S1130')
GROUP BY CustomerName, mc.CustomerID, StaffName, ms.StaffID, sth.SalesTransactionID, SalesTransactionDate, std.ServerID, ServerPrice
--The transaction has been completed



--3
--New Customer name Dinda wants to buy hardware on 24 January 2023 and needs to fill in their information such as ID, Name, Gender, email, Date of Birth, Phone Number, and Address.
INSERT INTO MsCustomer VALUES 
('JCN-C3212','Dinda','Female','dinda3212@gmail.com','1999/05/12','081234567890','Merdeka Street 12')

--The transaction is served by Budi Karyano ,the staff needs to fill in the data for Sales Transaction such as SalesTransaction ID, Staff ID, Customer ID, SalesTransaction Date, and Server ID.
INSERT INTO SalesTransactionHeader VALUES
('JCN-S1131','JCN-S4287','JCN-C3212','2023/01/24')
INSERT INTO SalesTransactionDetail VALUES
('JCN-S1131','JCN-V5121'),
('JCN-S1131','JCN-V5122')

-- After that, the staff will provide an invoice to the customer containing information on the transaction made
SELECT CustomerName, mc.CustomerID, StaffName, ms.StaffID, sth.SalesTransactionID, SalesTransactionDate, std.ServerID, ServerPrice, SUM(ServerPrice) AS TotalPrice
	FROM MsCustomer mc
	JOIN SalesTransactionHeader sth
	ON mc.CustomerID = sth.CustomerID
	JOIN MsStaff ms
	ON ms.StaffID = sth.StaffID
	JOIN SalesTransactionDetail std
	ON sth.SalesTransactionID = std.SalesTransactionID
	JOIN MsServer mv
	ON std.ServerID = mv.ServerID
WHERE sth.SalesTransactionID IN ('JCN-S1131')
GROUP BY CustomerName, mc.CustomerID, StaffName, ms.StaffID, sth.SalesTransactionID, SalesTransactionDate, std.ServerID, ServerPrice
--The transaction has been completed



--4
--New Customer named Rudianto wants to rent a server on 10 October 2022 for 6 Months and needs to fill in their information such as ID, Name, Gender, email, Date of Birth, Phone Number, and Address.
INSERT INTO MSCustomer VALUES
('JCN-C3217','Rudianto','Male','rudia@yahoo.com','1995/09/30','085678901235','Indah Makmur 567')

--The transaction is served by Darlene Adventia,the staff needs to fill in the data for Rental Transaction such as Rental ID, Staff ID, Customer ID, Rental Start Date, Server ID, and Rental Duration (In Months)
INSERT INTO RentalTransactionHeader VALUES
('JCN-R1263','JCN-S4293','JCN-C3217','2022/10/10')
INSERT INTO RentalTransactionDetail VALUES
('JCN-R1263','JCN-V5122','6'),
('JCN-R1263','JCN-V5124','12')

-- After that, the staff will provide an invoice to the customer containing information on the transaction made
SELECT CustomerName, mc.CustomerID, StaffName, ms.StaffID, rth.RentalTransactionID, RentalStartDate, RentalDuration, rtd.ServerID, ServerPrice, SUM(ServerPrice/12*RentalDuration) AS TotalPrice
	FROM MsCustomer mc
	JOIN RentalTransactionHeader rth
	ON mc.CustomerID = rth.CustomerID
	JOIN MsStaff ms
	ON ms.StaffID = rth.StaffID
	JOIN RentalTransactionDetail rtd
	ON rth.RentalTransactionID = rtd.RentalTransactionID
	JOIN MsServer mv
	ON rtd.ServerID = mv.ServerID
WHERE rth.RentalTransactionID IN ('JCN-R1263')
GROUP BY CustomerName, mc.CustomerID, StaffName, ms.StaffID, rth.RentalTransactionID, RentalStartDate,RentalDuration, rtd.ServerID, ServerPrice
--The transaction has been completed




--5
--Old customer named Margono Basri want to rent a server on 27 May 2023 for 2 years. The transaction is served by Jeremy Toruan, the staff need to fill in the data for Rental Transaction such as RentalTransaction ID, Staff ID, Customer ID, RentalStart Date, Server ID, and Rental Duration (In Months)
INSERT INTO RentalTransactionHeader VALUES
('JCN-R1270','JCN-S4292','JCN-C3299','2023/05/27')
INSERT INTO RentalTransactionDetail VALUES
('JCN-R1270','JCN-V5122','24')

-- After that, the staff will provide an invoice to the customer containing information on the transaction made
SELECT CustomerName, mc.CustomerID, StaffName, ms.StaffID, rth.RentalTransactionID, RentalStartDate, RentalDuration, rtd.ServerID, ServerPrice, SUM(ServerPrice/12*RentalDuration) AS TotalPrice
	FROM MsCustomer mc
	JOIN RentalTransactionHeader rth
	ON mc.CustomerID = rth.CustomerID
	JOIN MsStaff ms
	ON ms.StaffID = rth.StaffID
	JOIN RentalTransactionDetail rtd
	ON rth.RentalTransactionID = rtd.RentalTransactionID
	JOIN MsServer mv
	ON rtd.ServerID = mv.ServerID
WHERE rth.RentalTransactionID IN ('JCN-R1270')
GROUP BY CustomerName, mc.CustomerID, StaffName, ms.StaffID, rth.RentalTransactionID, RentalStartDate,RentalDuration, rtd.ServerID, ServerPrice
--The transaction has been completed


--6
--Old customer named Jesslyn Hadinata wants to buy server on 27 May 2023. The transaction is served by Santika Putri. The transaction is served by Nathanael Noya, the staff need to fill in the data for Sales Transaction such as SalesTransaction ID, Staff ID, Customer ID, SalesTransaction Date, and Server ID
INSERT INTO SalesTransactionHeader VALUES
('JCN-S1137','JCN-S4291','JCN-C3144','2023/05/27')
INSERT INTO SalesTransactionDetail VALUES
('JCN-S1137','JCN-V5122'),
('JCN-S1137','JCN-V5126')

--After that, the staff will provide an invoice to the customer containing information on the transaction made
SELECT CustomerName, mc.CustomerID, StaffName, ms.StaffID, sth.SalesTransactionID, SalesTransactionDate, std.ServerID, ServerPrice, SUM(ServerPrice) AS TotalPrice
	FROM MsCustomer mc
	JOIN SalesTransactionHeader sth
	ON mc.CustomerID = sth.CustomerID
	JOIN MsStaff ms
	ON ms.StaffID = sth.StaffID
	JOIN SalesTransactionDetail std
	ON sth.SalesTransactionID = std.SalesTransactionID
	JOIN MsServer mv
	ON std.ServerID = mv.ServerID
WHERE sth.SalesTransactionID IN ('JCN-S1137')
GROUP BY CustomerName, mc.CustomerID, StaffName, ms.StaffID, sth.SalesTransactionID, SalesTransactionDate, std.ServerID, ServerPrice
--The transaction has been completed


--7
--Old customer named Desika Salina want to rent servers on 27 May 2023 for 7 months. The transaction is served by Jeremy Toruan, the staff need to fill in the data for Rental Transaction such as RentalTransaction ID, Staff ID, Customer ID, RentalStart Date, Server ID, and Rental Duration (In Months)
INSERT INTO RentalTransactionHeader VALUES
('JCN-R1272','JCN-S4292','JCN-C3133','2023/06/03')
INSERT INTO RentalTransactionDetail VALUES
('JCN-R1272','JCN-V5124','7'),
('JCN-R1272','JCN-V5131','7'),
('JCN-R1272','JCN-V5135','7')

-- After that, the staff will provide an invoice to the customer containing information on the transaction made
SELECT CustomerName, mc.CustomerID, StaffName, ms.StaffID, rth.RentalTransactionID, RentalStartDate, RentalDuration, rtd.ServerID, ServerPrice, SUM(ServerPrice/12*RentalDuration) AS TotalPrice
	FROM MsCustomer mc
	JOIN RentalTransactionHeader rth
	ON mc.CustomerID = rth.CustomerID
	JOIN MsStaff ms
	ON ms.StaffID = rth.StaffID
	JOIN RentalTransactionDetail rtd
	ON rth.RentalTransactionID = rtd.RentalTransactionID
	JOIN MsServer mv
	ON rtd.ServerID = mv.ServerID
WHERE rth.RentalTransactionID IN ('JCN-R1272')
GROUP BY CustomerName, mc.CustomerID, StaffName, ms.StaffID, rth.RentalTransactionID, RentalStartDate,RentalDuration, rtd.ServerID, ServerPrice
--The transaction has been completed


--8
--Old customer named Stephanie Doro wants to buy a server and rent a server on 01 June 2023 for 6 months. The transaction is served by Felix Tandu, the staff need to fill in the data for Sales Transaction such as SalesTransaction ID, Staff ID, Customer ID, SalesTransaction Date, and Server ID. The staff also need to fill in the data for Rental Transaction such as RentalTransaction ID, Staff ID, Customer ID, RentalStart Date, Server ID, and Rental Duration (In Months)
INSERT INTO SalesTransactionHeader VALUES
('JCN-S1139','JCN-S4294','JCN-C3277','2023/06/01')
INSERT INTO SalesTransactionDetail VALUES
('JCN-S1139','JCN-V5124')
INSERT INTO RentalTransactionHeader VALUES
('JCN-R1274','JCN-S4294','JCN-C3277','2023/06/01')
INSERT INTO RentalTransactionDetail VALUES
('JCN-R1274','JCN-V5135','6')

-- After that, the staff will provide invoices to the customer containing information on the transaction made
SELECT CustomerName, mc.CustomerID, StaffName, ms.StaffID, sth.SalesTransactionID, SalesTransactionDate, std.ServerID, ServerPrice, SUM(ServerPrice) AS TotalPrice
	FROM MsCustomer mc
	JOIN SalesTransactionHeader sth
	ON mc.CustomerID = sth.CustomerID
	JOIN MsStaff ms
	ON ms.StaffID = sth.StaffID
	JOIN SalesTransactionDetail std
	ON sth.SalesTransactionID = std.SalesTransactionID
	JOIN MsServer mv
	ON std.ServerID = mv.ServerID
WHERE sth.SalesTransactionID IN ('JCN-S1139')
GROUP BY CustomerName, mc.CustomerID, StaffName, ms.StaffID, sth.SalesTransactionID, SalesTransactionDate, std.ServerID, ServerPrice

SELECT CustomerName, mc.CustomerID, StaffName, ms.StaffID, rth.RentalTransactionID, RentalStartDate, RentalDuration, rtd.ServerID, ServerPrice, SUM(ServerPrice/12*RentalDuration) AS TotalPrice
	FROM MsCustomer mc
	JOIN RentalTransactionHeader rth
	ON mc.CustomerID = rth.CustomerID
	JOIN MsStaff ms
	ON ms.StaffID = rth.StaffID
	JOIN RentalTransactionDetail rtd
	ON rth.RentalTransactionID = rtd.RentalTransactionID
	JOIN MsServer mv
	ON rtd.ServerID = mv.ServerID
WHERE rth.RentalTransactionID IN ('JCN-R1274')
GROUP BY CustomerName, mc.CustomerID, StaffName, ms.StaffID, rth.RentalTransactionID, RentalStartDate,RentalDuration, rtd.ServerID, ServerPrice
--The transaction has been completed
