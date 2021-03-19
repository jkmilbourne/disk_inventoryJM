--Project 2
--SWDV 220
--Joshua Milbourne

/*******************************************************************************************
**	Date		Programmer			Description
**	03/05/21	Joshua Milbourne	Created Database and user for disk_inventoryJM
**  03/12/21	Joshua Milbourne	Created all SQL to insert data into all tables
**  03/19/21	Joshua Milbourne	Added Reports for Project 4
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
	releaseDate		DATE NOT NULL,
	statusCode		INT NOT NULL REFERENCES status(statusCode),
	genreCode		INT NOT NULL REFERENCES genre(genreCode),
	diskTypeID		INT NOT NULL REFERENCES diskType(diskTypeCode)
	);

-- Create diskHasBorrower and DiskHasArtist tables

CREATE TABLE diskHasBorrower
	(
	diskHasBorrowerID	INT NOT NULL IDENTITY PRIMARY KEY,
	borrowedDate		DATETIME NOT NULL DEFAULT GETDATE(),
	dueDate				DATETIME NOT NULL DEFAULT (GETDATE() + 30),
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

-------------------------------------------Inserts into lookup tables

--Insert all information into artistType table
INSERT INTO artistType(artistTypeDesc)
VALUES ('Solo')
INSERT INTO artistType(artistTypeDesc)
VALUES ('Group')
;

--Insert all information into diskType table
INSERT INTO diskType(diskTypeDesc)
VALUES ('CD')
INSERT INTO diskType(diskTypeDesc)
VALUES ('LP')
INSERT INTO diskType(diskTypeDesc)
VALUES ('DVD')
INSERT INTO diskType(diskTypeDesc)
VALUES ('VHS')
INSERT INTO diskType(diskTypeDesc)
VALUES ('Video Game')
INSERT INTO diskType(diskTypeDesc)
VALUES ('BLuRay')
;

--Insert all information into genre table
INSERT INTO genre(genreDesc)
VALUES('Rock')
INSERT INTO genre(genreDesc)
VALUES('Classical')
INSERT INTO genre(genreDesc)
VALUES('Soundtrack')
INSERT INTO genre(genreDesc)
VALUES('Jazz')
INSERT INTO genre(genreDesc)
VALUES('R&B')
INSERT INTO genre(genreDesc)
VALUES('Funk')
INSERT INTO genre(genreDesc)
VALUES('Pop')
INSERT INTO genre(genreDesc)
VALUES('Comedy')
INSERT INTO genre(genreDesc)
VALUES('Horror')
INSERT INTO genre(genreDesc)
VALUES('Action')
INSERT INTO genre(genreDesc)
VALUES('Thriller')
INSERT INTO genre(genreDesc)
VALUES('RomCom')
INSERT INTO genre(genreDesc)
VALUES('Video Game')
;

--Insert all information into status table
INSERT INTO status(statusDesc)
VALUES('Inventory')
INSERT INTO status(statusDesc)
VALUES('Borrowed')
INSERT INTO status(statusDesc)
VALUES('Maintenance')
INSERT INTO status(statusDesc)
VALUES('Retired')
;

-----------------------------------------------Inserts into artist borrower and disk tables

--Insert all information into artist table
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES(NULL, 'Tower of Power', 2)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES(NULL, 'Beatles, The', 2)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES('Stephen', 'Sondheim', 1)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES('Billy', 'Joel', 1)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES('Harry, Jr.', 'Connick', 1)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES('Andrew Lloyd', 'Webber', 1)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES('Stevie', 'Wonder', 1)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES('NULL', 'Who, The', 2)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES('Wolfgang Amadeus', 'Mozart', 1)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES(NULL, 'Rodgers & Hamerstein', 2)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES(NULL, 'Beach Boys, The', 2)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES(NULL, 'Prince', 1)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES(NULL, 'They Might Be Giants', 2)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES(NULL, 'Aerosmith', 2)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES(NULL, 'Journey', 2)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES('Lin-Manuel', 'Miranda', 1)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES('Robert', 'Lopez', 1)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES('Jason Robert', 'Brown', 1)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES('Jimi', 'Hendrix', 1)
INSERT INTO artist(artistFName, artistLName, artistTypeCode)
VALUES(NULL, 'Clash, The', 2)

;

--Insert all information into borrower table
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Jennifer', NULL, 'Aniston', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Taylor', NULL, 'Swift', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Will', NULL, 'Smith', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Dwayne', NULL, 'Johnson', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Kim', NULL, 'Kardashian', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Mark', NULL, 'Wahlberg', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Jennifer', NULL, 'Lopez', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Ariana', NULL, 'Grande', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Brad', NULL, 'Pitt', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Robert, Jr.', NULL, 'Downey', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Tom', NULL, 'Hanks', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Leonardo', NULL, 'DiCaprio', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Britney', NULL, 'Spears', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Oprah', NULL, 'Winfrey', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Kevin', NULL, 'Hart', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Tom', NULL, 'Cruise', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Jerry', NULL, 'Seinfeld', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('George', NULL, 'Clooney', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Vin', NULL, 'Diesel', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Matt', NULL, 'Damon', '123-456-7890')
INSERT INTO borrower(fname, mi, lname, phone)
VALUES('Orlando', NULL, 'Bloom', '123-456-7890')
;

--Insert all information into disk table
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Tower Of Power', '7/17/2001', 1, 1, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Revolver', '8/5/1966', 1, 1, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Sunday in the Park with George', '12/8/2017', 2, 3, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('River of Dreams', '8/10/1993', 1, 1, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('25', '11/24/1992', 1, 4, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Aspects of Love', '2/14/1989', 1, 3, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('With A Song In My Heart', '12/28/1963', 2, 5, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Tommy', '5/17/1969', 2, 1, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Mozart - Great Recordings', '6/1/2020', 2, 2, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Carousel(1993 London Cast Recording)', '10/15/1993', 2, 3, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Pet Sounds', '5/16/1966', 2, 1, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('The Hits 1', '9/10/1993', 2, 7, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Flood', '1/15/1990', 2, 8, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Rocks', '5/14/1976', 2, 1, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Evolution', '3/23/1979', 2, 1, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('A Little Night Music', '4/6/2010', 2, 3, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Evita', '9/25/1979', 2, 3, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Today!', '3/8/1965', 1, 1, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('Movin Out', '11/1/1977', 2, 1, 1)
INSERT INTO disk(diskName, releaseDate, statusCode, genreCode, diskTypeID)
VALUES('They Might Be Giants', '11/4/1986', 2, 8, 1)
;

----------------------------------------------Inserts into diskHasBorrower and DiskHasArtist tables

--Insert all information into diskHasBorrower table
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES('April 4, 2018', DEFAULT, 'May 4, 2018', 20, 1)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES('April 5, 2018', DEFAULT, 'May 5, 2018', 20, 5)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES('April 6, 2018', DEFAULT, 'May 6, 2018', 18, 3)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES('April 7, 2018', DEFAULT, 'May 7, 2018', 17, 4)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES('April 8, 2018', DEFAULT, 'May 8, 2018', 16, 5)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES('April 9, 2018', DEFAULT, 'May 9, 2018', 15, 6)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 14, 7)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 13, 8)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 12, 9)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 11, 10)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 10, 11)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 9, 12)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 8, 13)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 7, 14)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 6, 15)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 5, 16)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 4, 17)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 18, 3)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 2, 19)
INSERT INTO diskHasBorrower(borrowedDate, dueDate, returnedDate, borrowerID, diskID)
VALUES(DEFAULT, DEFAULT, NULL, 1, 20)
;

--Insert all information into diskHasArtist table
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(1, 1)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(2, 2)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(3, 3)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(4, 4)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(5, 5)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(6, 6)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(7, 7)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(8, 8)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(9, 9)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(10, 10)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(11, 11)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(12, 12)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(13, 13)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(14, 14)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(15, 15)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(3, 16)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(6, 17)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(11, 18)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(4, 19)
INSERT INTO diskHasArtist(artistID, diskID)
VALUES(13, 20)
;


--Update only one row using a WHERE clause in disk table
--Change genre code from 1 to 6 on Tower Of Power disk
UPDATE disk
SET genreCode = 6
WHERE diskID = 1;

--Delete only 1 row using a WHERE clause
--Delete Orlando Bloom from borrower table borrowerID = 21
DELETE FROM borrower
WHERE borrowerID = 21;

--Create a query to list the disks that are on loan and have not been returned
--SELECT query for all columns from diskHasBorrower table where the retunedDate equals NULL
SELECT fname AS 'First', lname AS 'Last', diskName AS 'Disk Name', CONVERT(VARCHAR, borrowedDate, 101) AS 'Borrowed Date', CONVERT(VARCHAR, dueDate, 101) AS 'Due Date', CONVERT(VARCHAR, returnedDate, 101) AS 'Returned Date'
FROM diskHasBorrower dhb
	JOIN disk d ON d.diskID = dhb.diskID
	JOIN borrower b ON b.borrowerID = dhb.borrowerID
WHERE returnedDate IS NULL;


--Project 4
--3. Show the disks in your database and any associated Individual artists only.
SELECT diskName, releaseDate, artistFName, artistLName
FROM disk d
	JOIN diskHasArtist dha ON d.diskID = dha.diskID
	JOIN artist a ON a.artistID = dha.artistID
WHERE artistTypeCode = 1
ORDER BY diskName
;
GO

--4. Create a view called View_Individual_Artist that shows the artists names and not group names. Include the artist id in the view definition but do not display the id in your output.

--Drop VIEW if it exists
DROP VIEW IF EXISTS View_Individual_artist;
GO

--Create the view table View_Individual_Artist
CREATE VIEW View_Individual_Artist AS
SELECT artistID, artistFName, artistLName
FROM artist a
	JOIN artistType atp ON atp.artistTypeCode = a.artistTypeCode
WHERE atp.artistTypeCode <> 2
;
GO

--Verify correct information from create view
SELECT artistFName AS 'First', artistLName AS 'Last'
FROM View_Individual_Artist
ORDER BY artistLName
;
GO


--5. Show the disks in your database and any associated Group artists only.
SELECT diskName AS 'Disk Name', CONVERT(VARCHAR, releaseDate, 101) AS 'Released Date', artistLName AS 'Group Name'
FROM disk d
	JOIN diskHasArtist dha ON d.diskID = dha.diskID
	JOIN artist a ON a.artistID = dha.artistID
	JOIN artistType aty ON aty.artistTypeCode = a.artistTypeCode
WHERE aty.artistTypeCode = 2
ORDER BY diskName
;
GO


--6. Re-write the previous query using the View_Individual_Artist view. Do not redefine the view. Use NOT EXISTS or NOT IN as the only restriction in the WHERE clause. The output matches the output from the previous query.
SELECT diskName AS 'Disk Name', CONVERT(VARCHAR, releaseDate, 101) AS 'Released Date', artistLName AS 'Group Name'
FROM disk d
	JOIN diskHasArtist dha ON d.diskID = dha.diskID
	JOIN artist a ON a.artistID = dha.artistID
	JOIN artistType aty ON aty.artistTypeCode = a.artistTypeCode
WHERE a.artistID NOT IN 
	(SELECT artistID FROM View_Individual_Artist)
ORDER BY diskName
;
GO 

--7. Show the borrowed disks and who borrowed them.
SELECT fname AS 'First', lname AS 'Last', diskName AS 'Disk Name', CONVERT(VARCHAR, borrowedDate, 101) AS 'Borrowed Date', CONVERT(VARCHAR, returnedDate, 101) AS 'Returned Date' 
FROM borrower b
	JOIN diskHasBorrower dhb ON dhb.borrowerID = b.borrowerID
	JOIN disk d ON d.diskID = dhb.diskID
ORDER BY 3, 2
;

--8. Show the number of times a disk has been borrowed.
SELECT d.diskID AS 'Disk ID', diskName AS 'Disk Name', COUNT(*) AS 'Times Borrowed'
FROM disk d
	JOIN diskHasBorrower dhb ON d.diskID = dhb.diskID
GROUP BY d.diskID, diskName
ORDER BY 1
;


--9. Show the disks outstanding or on-loan and who has each disk.
SELECT diskName AS 'Disk Name', CONVERT(VARCHAR, borrowedDate, 101) AS 'Borrowed', CONVERT(VARCHAR, returnedDate, 101) AS 'Returned', lname AS 'Last Name'
FROM disk d
	JOIN diskHasBorrower dhb ON dhb.diskID = d.diskID
	JOIN borrower b ON dhb.borrowerID = b.borrowerID
WHERE returnedDate IS NULL
ORDER BY diskName
;

