--Project 2
--SWDV 220
--Joshua Milbourne

/*******************************************************************************************
**	Date		Programmer			Description
**	03/05/21	Joshua Milbourne	Created Database and user for disk_inventoryJM
********************************************************************************************/

------------------------- create database --

-- use the master database
USE master;
go

--Drop the table if it exists
DROP DATABASE IF EXISTS disk_inventoryJM;
go

--Create the database
CREATE DATABASE disk_inventoryJM;
go

-- switch to newly created disk_inventoryJM database
USE disk_inventoryJM;
go

------------------- create login, user & grant read permissions --

--Create the Login if it doesn't exist for diskUserJM with password Pa$$w0rd 
IF SUSER_ID('diskUserJM') IS NULL
	CREATE LOGIN diskUserJM
	WITH PASSWORD = 'Pa$$w0rd',
	DEFAULT_DATABASE = disk_inventoryJM;

--Drop diskUserJm if already in database
DROP USER IF EXISTS diskUserJM;

-- Create the user diskUserJM
CREATE USER diskUserJM;

--Give diskUserJm read permission on full database
ALTER ROLE db_datareader
	ADD MEMBER diskUserJM;
go



--------------------------- create tables --

--create look-up tables artistType, diskType, gerne, status

CREATE TABLE artistType
	(
	artistTypeCode	INT NOT NULL IDENTITY PRIMARY KEY,
	artistTypeDesc	VARCHAR(255) NOT NULL
	);

CREATE TABLE diskType
	(
	diskTypeCode	INT NOT NULL IDENTITY PRIMARY KEY,
	diskTypeDesc	VARCHAR(255) NOT NULL
	);

CREATE TABLE genre
	(
	genreCode		INT NOT NULL IDENTITY PRIMARY KEY,
	genreDesc		VARCHAR(255) NOT NULL
	);

CREATE TABLE status
	(
	statusCode		INT NOT NULL IDENTITY PRIMARY KEY,
	statusDesc		VARCHAR(255) NOT NULL
	);

-- create artist borrower and disk tables

CREATE TABLE artist
	(
	artistID		INT NOT NULL IDENTITY PRIMARY KEY,
	artistFName		VARCHAR(255) NULL,
	artistLName		VARCHAR(255) NOT NULL,
	artistTypeCode	INT NOT NULL REFERENCES artistType(artistTypeCode)
	);

CREATE TABLE borrower
	(
	borrowerID		INT NOT NULL IDENTITY PRIMARY KEY,
	fname			VARCHAR(255) NOT NULL,
	mi				VARCHAR(10) NULL,
	lname			VARCHAR(255) NOT NULL,
	phone			VARCHAR(20) NOT NULL
	);

CREATE TABLE disk
	(
	diskID			INT NOT NULL IDENTITY PRIMARY KEY,
	diskName		VARCHAR(255) NOT NULL,
	releaseDate		DATETIME NOT NULL,
	statusCode		INT NOT NULL REFERENCES status(statusCode),
	genreCode		INT NOT NULL REFERENCES genre(genreCode),
	diskTypeID		INT NOT NULL REFERENCES diskType(diskTypeCode)
	);

-- Create diskHasBorrower and DiskHasArtist tables

CREATE TABLE diskHasBorrower
	(
	diskHasBorrowerID	INT NOT NULL IDENTITY PRIMARY KEY,
	borrowedDate		DATETIME NOT NULL DEFAULT GETDATE(),
	dueDate				DATETIME NOT NULL DEFAULT (GETDATE() +30),
	returnedDate		DATETIME NULL,
	borrowerID			INT NOT NULL REFERENCES borrower(borrowerID),
	diskID				INT NOT NULL REFERENCES disk(diskID)
	);

CREATE TABLE diskHasArtist
	(
	diskHasArtistID	INT NOT NULL IDENTITY PRIMARY KEY,
	artistID		INT NOT NULL REFERENCES artist(artistID),
	diskID			INT NOT NULL REFERENCES disk(diskID)
	);


--Project 3
--Insert into lookup tables

--Inserts for artistType
INSERT INTO artistType
VALUES ('Solo')
INSERT INTO artistType
VALUES ('Group')
;

--Inserts for diskType
INSERT INTO diskType
VALUES ('CD')
INSERT INTO diskType
VALUES ('LP')
INSERT INTO diskType
VALUES ('DVD')
INSERT INTO diskType
VALUES ('VHS')
INSERT INTO diskType
VALUES ('Video Game')
INSERT INTO diskType
VALUES ('BLuRay')
;

--Inserts into genre
INSERT INTO genre
VALUES('Rock')
INSERT INTO genre
VALUES('Classical')
INSERT INTO genre
VALUES('Soundtrack')
INSERT INTO genre
VALUES('Jazz')
INSERT INTO genre
VALUES('R&B')
INSERT INTO genre
VALUES('Funk')
INSERT INTO genre
VALUES('Pop')
INSERT INTO genre
VALUES('Comedy')
INSERT INTO genre
VALUES('Horror')
INSERT INTO genre
VALUES('Action')
INSERT INTO genre
VALUES('Thriller')
INSERT INTO genre
VALUES('RomCom')
INSERT INTO genre
VALUES('Video Game')
;

--Inserts into status
INSERT INTO status
VALUES('Inventory')
INSERT INTO status
VALUES('Borrowed')
INSERT INTO status
VALUES('Maintenance')
INSERT INTO status
VALUES('Retired')
;

--Inserts into artist borrower and disk tables
