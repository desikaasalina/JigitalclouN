GO
CREATE DATABASE JigitalclouN
GO
USE JigitalclouN

--DDL CREATE TABLE--
CREATE TABLE MsStaff (
	StaffID CHAR(9) PRIMARY KEY CHECK (StaffID LIKE 'JCN-S[3-7][1-2][0-9][0-9]'),
	StaffName VARCHAR(50) NOT NULL,
	StaffGender VARCHAR(6) CHECK (StaffGender IN ('Male', 'Female')) NOT NULL,
	StaffEmail VARCHAR(50) CHECK (StaffEmail LIKE '_%@_%._%') NOT NULL,
	StaffDOB DATE NOT NULL,
	StaffPhone VARCHAR(20) NOT NULL,
	StaffAddress VARCHAR(100) NOT NULL,
	StaffSalary INT CHECK (StaffSalary > 3500000 AND StaffSalary < 20000000) NOT NULL
)

CREATE TABLE MsCustomer (
	CustomerID CHAR(9) PRIMARY KEY CHECK (CustomerID LIKE 'JCN-C[3-7][1-2][0-9][0-9]'),
	CustomerName VARCHAR(50) NOT NULL,
	CustomerGender VARCHAR(6) CHECK (CustomerGender IN ('Male', 'Female')) NOT NULL,
	CustomerEmail VARCHAR(50) CHECK (CustomerEmail LIKE '_%@_%._%') NOT NULL,
	CustomerDOB DATE CHECK (DATEDIFF(YEAR, CustomerDOB, GETDATE()) >= 15) NOT NULL,
	CustomerPhone VARCHAR(20) NOT NULL,
	CustomerAddress VARCHAR(100) NOT NULL
)

CREATE TABLE MsMemory (
	MemoryID CHAR(9) PRIMARY KEY CHECK (MemoryID LIKE 'JCN-M[3-7][1-2][0-9][0-9]'),
	MemoryName VARCHAR(50) NOT NULL,
	MemoryModelCode VARCHAR(50) NOT NULL,
	MemoryPrice INT NOT NULL,
	MemoryFrequency INT CHECK (MemoryFrequency BETWEEN 1000 AND 5000) NOT NULL,
	MemoryCapacity INT CHECK (MemoryCapacity BETWEEN 1 AND 256) NOT NULL
)

CREATE TABLE MsProcessor (
	ProcessorID CHAR(9) PRIMARY KEY CHECK (ProcessorID LIKE 'JCN-P[3-7][1-2][0-9][0-9]'),
	ProcessorName VARCHAR(50) NOT NULL,
	ProcessorModelCode VARCHAR(50) NOT NULL,
	ProcessorPrice INT NOT NULL,
	ProcessorClockSpeed FLOAT CHECK (ProcessorClockSpeed BETWEEN 1500 AND 6000) NOT NULL,
	ProcessorCores INT CHECK (ProcessorCores BETWEEN 1 AND 24) NOT NULL
)

CREATE TABLE MsLocation (
	LocationID CHAR(9) PRIMARY KEY CHECK (LocationID LIKE 'JCN-L[3-7][1-2][0-9][0-9]'),
	LocationCity VARCHAR(50) NOT NULL,
	LocationCountry VARCHAR(50) NOT NULL,
	LocationZipCode VARCHAR(10) NOT NULL,
	LocationLatitude DECIMAL(9,6) CHECK (LocationLatitude BETWEEN -90 AND 90) NOT NULL,
	LocationLongitude DECIMAL(9,6) CHECK (LocationLongitude BETWEEN -180 AND 180) NOT NULL
)

CREATE TABLE MsServer (
	ServerID CHAR(9) PRIMARY KEY CHECK (ServerID LIKE 'JCN-V[3-7][1-2][0-9][0-9]'),
	MemoryID CHAR(9) FOREIGN KEY REFERENCES MsMemory(MemoryID) NOT NULL,
	ProcessorID CHAR(9) FOREIGN KEY REFERENCES MsProcessor(ProcessorID) NOT NULL,
	LocationID CHAR(9) FOREIGN KEY REFERENCES MsLocation(LocationID) NOT NULL,
	ServerPrice INT NOT NULL
)

CREATE TABLE SalesTransactionHeader (
	SalesTransactionID CHAR(9) PRIMARY KEY CHECK (SalesTransactionID LIKE 'JCN-S[0-2][1-2][0-9][0-9]'),
	StaffID CHAR(9) FOREIGN KEY REFERENCES MsStaff(StaffID) NOT NULL,
	CustomerID CHAR(9) FOREIGN KEY REFERENCES MsCustomer(CustomerID) NOT NULL,
	SalesTransactionDate DATE NOT NULL
)

CREATE TABLE RentalTransactionHeader (
	RentalTransactionID CHAR(9) PRIMARY KEY CHECK (RentalTransactionID LIKE 'JCN-R[0-2][1-2][0-9][0-9]'),
	StaffID CHAR(9) FOREIGN KEY REFERENCES MsStaff(StaffID) NOT NULL,
	CustomerID CHAR(9) FOREIGN KEY REFERENCES MsCustomer(CustomerID) NOT NULL,
	RentalStartDate DATE CHECK (YEAR(RentalStartDate) >= 2012 AND RentalStartDate < GETDATE()) NOT NULL
)

CREATE TABLE RentalTransactionDetail (
	RentalTransactionID CHAR(9) FOREIGN KEY REFERENCES RentalTransactionHeader(RentalTransactionID),
	ServerID CHAR(9) FOREIGN KEY REFERENCES MsServer(ServerID),
	RentalDuration INT NOT NULL,
	PRIMARY KEY(RentalTransactionID, ServerID)
)

CREATE TABLE SalesTransactionDetail (
	SalesTransactionID CHAR(9) FOREIGN KEY REFERENCES SalesTransactionHeader(SalesTransactionID),
	ServerID CHAR(9) FOREIGN KEY REFERENCES MsServer(ServerID),
	PRIMARY KEY(SalesTransactionID, ServerID)
)


