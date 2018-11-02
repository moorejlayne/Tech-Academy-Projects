/* ----------------------------------------------
-------------------------------------------------
Jacob L Moore
11/02/18
The Tech Academy Databases Final Project 
-------------------------------------------------
---------------------------------------------- */

/* ----------------------------------------------
-------------------------------------------------
Create Database
-------------------------------------------------
---------------------------------------------- */
CREATE DATABASE db_arkham_library

/* ----------------------------------------------
-------------------------------------------------
Create Tables
-------------------------------------------------
---------------------------------------------- */
CREATE TABLE tbl_libraryBranch (
    libraryBranch_branchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
    libraryBranch_branchName VARCHAR(100) NOT NULL,
    libraryBranch_address VARCHAR(150) NOT NULL
)

CREATE TABLE tbl_publisher (
    publisher_publisherName VARCHAR(100) PRIMARY KEY NOT NULL,
    publisher_address VARCHAR(150) NOT NULL,
    publisher_phone CHAR(12)
)

CREATE TABLE tbl_books (
    books_bookID INT PRIMARY KEY NOT NULL IDENTITY (100,1),
    books_title VARCHAR(200) NOT NULL,
    books_publisherName VARCHAR(100) NOT NULL CONSTRAINT fk_publisher_publisherName FOREIGN KEY REFERENCES tbl_publisher(publisher_publisherName) ON UPDATE CASCADE ON DELETE CASCADE,
)

CREATE TABLE tbl_bookAuthors (
    bookAuthors_bookID INT NOT NULL CONSTRAINT fk4_books_bookID FOREIGN KEY REFERENCES tbl_books(books_bookID) ON UPDATE CASCADE ON DELETE CASCADE,
    bookAuthors_authorName VARCHAR(100) NOT NULL 
)

CREATE TABLE tbl_bookCopies (
    bookCopies_bookID INT NOT NULL CONSTRAINT fk2_books_bookID FOREIGN KEY REFERENCES tbl_books(books_bookID) ON UPDATE CASCADE ON DELETE CASCADE,
    bookCopies_branchID INT NOT NULL CONSTRAINT fk_libraryBranch_branchID FOREIGN KEY REFERENCES tbl_libraryBranch(libraryBranch_branchID) ON UPDATE CASCADE ON DELETE CASCADE,
    bookCopies_numberOfCopies INT NOT NULL
)

CREATE TABLE tbl_borrower (
    borrower_cardNo INT NOT NULL PRIMARY KEY IDENTITY (1000,1),
    borrower_name VARCHAR(100) NOT NULL,
    borrower_address VARCHAR(150) NOT NULL,
    borrower_phone CHAR(12)
)

CREATE TABLE tbl_bookLoans (
    bookLoans_bookID INT NOT NULL CONSTRAINT fk3_books_bookID FOREIGN KEY REFERENCES tbl_books(books_bookID) ON UPDATE CASCADE ON DELETE CASCADE,
    bookLoans_branchID INT NOT NULL CONSTRAINT fk2_libraryBranch_branchID FOREIGN KEY REFERENCES tbl_libraryBranch(libraryBranch_branchID) ON UPDATE CASCADE ON DELETE CASCADE,
    bookLoans_cardNo INT NOT NULL CONSTRAINT fk_borrower_cardNo FOREIGN KEY REFERENCES tbl_borrower(borrower_cardNo) ON UPDATE CASCADE ON DELETE CASCADE,
    bookLoans_dateOut DATE NOT NULL,
    bookLoans_dateDue DATE NOT NULL
)


/* ----------------------------------------------
-------------------------------------------------
Populate Tables
-------------------------------------------------
---------------------------------------------- */
INSERT INTO tbl_libraryBranch
    (libraryBranch_branchName, libraryBranch_address)
    VALUES
    ('Sharpstown', '1826 Levy Court, Arkham MA 01915'),
    ('Central', '3106 Leverton Cove Road, Arkham MA 01915'),
    ('Miskatonic', '4526 Trails End Road, Arkham MA 01915'),
    ('French Hill', '4022 Fulton Street, Arkham MA 01915')
;

INSERT INTO tbl_publisher
    (publisher_publisherName, publisher_address, publisher_phone) 
    VALUES
    ('Anchor','2709 Cunningham Court, Commerce MI 48387','248-698-8975'),
    ('Ballantine','3503 Linden Avenue, Orlando FL 32789','407-554-4866'),
    ('Bantam','510 Fulton Street, Charleston WV 25301','304-388-9669'),
    ('Berkley','3770 Morningview Lane, Riceville IA 50466','641-985-7113'),
    ('Pantheon','350 Dennison Street, Modesto CA 95354','209-577-6358'),
    ('Pegasus','3784 Brown Avenue, Easley SC 29640','864-859-0170'),
    ('Penguin','640 Shinn Street, New York NY 10019','212-757-4252'),
    ('Prestwick House','1651 Heritage Road, Fresno CA 93721','559-742-4226'),
    ('Vintage','2888 Briarwood Drive, Laurel Springs NJ 08021','856-477-6524')
;

INSERT INTO tbl_books
    (books_title, books_publisherName)
    VALUES
    ('I.T.','Anchor'),
    ('The Stand','Anchor'),
    ('Cujo','Anchor'),
    ('Interview with a Vampire','Ballantine'),
    ('The Lost Tribe','Bantam'),
    ('The Damnation Game','Berkley'),
    ('Darkfall','Berkley'),
    ('The Haunting of Hill House','Berkley'),
    ('House of Leaves','Pantheon'),
    ('At the Mountains of Madness','Penguin'),
    ('Necronomicon','Penguin'),
    ('The Dunwich Horror','Penguin'),
    ('The Whisperer in the Darkness','Penguin'),
    ('Something Wicked This Way Comes','Penguin'),
    ('Dracula','Penguin'),
    ('Franekstein','Penguin'),
    ('The Raven','Prestwick House'),
    ('The Fall of the House of Usher','Prestwick House'),
    ('The Tell-Tale Heart','Prestwick House'),
    ('The Silence of the Lambs','Anchor'),
    ('Red Dragon','Anchor'),
    ('The Woman in Black','Vintage')
;
    
INSERT INTO tbl_bookAuthors
    (bookAuthors_bookID, bookAuthors_authorName)
    VALUES
    (101,'Stephen King'),
    (102,'Stephen King'),
    (103,'Stephen King'),
    (104,'Anne Rice'),
    (105,'Louise Munro Foley'),
    (106,'Clive Barker'),
    (107,'Dean Koontz'),
    (108,'Shirley Jackson'),
    (109,'Mark Z. Danielewski'),
    (110,'H.P. Lovecraft'),
    (111,'H.P. Lovecraft'),
    (112,'H.P. Lovecraft'),
    (113,'H.P. Lovecraft'),
    (114,'Ray Bradbury'),
    (115,'Bram Stoker'),
    (116,'Mary Shelly'),
    (117,'Edgar Allan Poe'),
    (118,'Edgar Allan Poe'),
    (119,'Edgar Allan Poe'),
    (120,'Thomas Harris'),
    (121,'Thomas Harris'),
    (122,'Susan Hill')
;

INSERT INTO tbl_bookCopies
    (bookCopies_bookID, bookCopies_branchID, bookCopies_numberOfCopies)
    VALUES
-- IN SHARPSTOWN
    (101,1,4), (102,1,2), (103,1,2), (104,1,4), (105,1,6), (106,1,0), (107,1,5), (108,1,2), (109,1,6), (110,1,0), (111,1,2), (112,1,2),
    (113,1,4), (114,1,0), (115,1,3), (116,1,2), (117,1,2), (118,1,3), (119,1,3), (120,1,2), (121,1,3), (122,1,4),
-- IN CENTRAL
    (101,2,2), (102,2,3), (103,2,2), (104,2,4), (105,2,5), (106,2,5), (107,2,0), (108,2,0), (109,2,3), (110,2,2), (111,2,4), (112,2,2), 
    (113,2,4), (114,2,2), (115,2,2), (116,2,2), (117,2,0), (118,2,0), (119,2,2), (120,2,2), (121,2,2), (122,2,2),
-- IN MISKANTONIC
    (101,3,0), (102,3,0), (103,3,0), (104,3,2), (105,3,0), (106,3,0), (107,3,0), (108,3,0), (109,3,2), (110,3,2), (111,3,5), (112,3,4),
    (113,3,3), (114,3,2), (115,3,4), (116,3,5), (117,3,6), (118,3,0), (119,3,0), (120,3,0), (121,3,0), (122,3,0),
-- IN FRENCH HILL
    (101,4,5), (102,4,2), (103,4,0), (104,4,4), (105,4,2), (106,4,2), (107,4,3), (108,4,2), (109,4,5), (110,4,6), (111,4,0), (112,4,0), 
    (113,4,0), (114,4,0), (115,4,0), (116,4,0), (117,4,0), (118,4,0), (119,4,0), (120,4,4), (121,4,2), (122,4,3)
;

INSERT INTO tbl_borrower
    (borrower_name, borrower_address, borrower_phone)
    VALUES
    ('John L Henley','3418 Deer Ridge Drive, Arkham MA 01915','862-204-3581'),
    ('Michael E Rodriguez','104 Taylor Street, Arkham MA 01915','917-364-8283'),
    ('Bradley Ruiz','3584 Irish Lane, Arkham MA 01915','414-522-5655'),
    ('Bobby Alejandro','4817 Eastland Avenue, Arkham MA 01915','601-672-7082'),
    ('Ellen Jones','2504 Moonlight Drive, Arkham MA 01915','201-966-3208'),
    ('James Elliott','3605 Martha Street, Arkham MA 01915','928-209-0292'),
    ('Julie McCroskey','1771 Post Farm Road, Arkham MA 01915','404-936-2180'),
    ('Larry March','1820 Oak Way, Arkham MA 01915','402-440-4112'),
    ('Allen J Swenson','2897 Edgewood Avenue, Arkham MA 01915','209-908-8733'),
    ('Phuong Simmons','2262 Rivendell Drive, Arkham MA 01915','330-651-3705')
;

INSERT INTO tbl_bookLoans
    (bookLoans_bookID, bookLoans_branchID, bookLoans_cardNo, bookLoans_dateOut, bookLoans_dateDue)
    VALUES
    (101,1,1006,'2018-10-15','2018-10-30'),
    (102,1,1006,'2018-10-13','2018-10-28'),
    (103,1,1006,'2018-10-20','2018-11-04'),
    (108,1,1006,'2018-10-18','2018-11-02'),
    (112,1,1006,'2018-10-15','2018-10-30'),
    (118,1,1006,'2018-10-16','2018-10-31'),
    (122,1,1006,'2018-10-05','2018-10-20'),
    (107,2,1008,'2018-10-16','2018-10-31'),
    (108,2,1008,'2018-10-17','2018-11-01'),
    (101,2,1008,'2018-10-17','2018-11-01'),
    (114,2,1008,'2018-10-16','2018-10-31'),
    (119,2,1008,'2018-10-31','2018-11-15'),
    (113,3,1000,'2018-10-30','2018-11-14'),
    (111,3,1000,'2018-10-30','2018-11-14'),
    (117,3,1000,'2018-10-30','2018-11-14'),
    (116,3,1001,'2018-10-23','2018-11-07'),
    (101,4,1002,'2018-10-15','2018-10-30'),
    (103,4,1002,'2018-10-15','2018-10-30'),
    (107,4,1002,'2018-10-19','2018-11-03'),
    (109,4,1002,'2018-10-19','2018-11-03'),
    (122,4,1002,'2018-10-19','2018-11-03'),
    (102,4,1003,'2018-10-27','2018-11-11'),
    (113,4,1003,'2018-10-27','2018-11-11'),
    (106,1,1004,'2018-11-07','2018-11-22'),
    (107,1,1004,'2018-11-07','2018-11-22'),
    (110,1,1004,'2018-10-16','2018-10-31'),
    (111,1,1004,'2018-10-16','2018-10-31'),
    (115,1,1004,'2018-10-16','2018-10-31'),
    (118,1,1004,'2018-10-15','2018-10-30'),
    (120,1,1004,'2018-10-28','2018-11-12'),
    (120,1,1005,'2018-10-16','2018-10-31'),
    (121,1,1005,'2018-10-24','2018-11-08'),
    (108,1,1005,'2018-10-24','2018-11-08'),
    (107,2,1007,'2018-11-08','2018-11-23'),
    (104,2,1007,'2018-11-08','2018-11-23'),
    (105,2,1007,'2018-10-16','2018-10-31'),
    (108,2,1007,'2018-10-16','2018-10-31'),
    (109,2,1007,'2018-10-16','2018-10-31'),
    (114,2,1007,'2018-10-25','2018-11-09'),
    (117,2,1007,'2018-10-25','2018-11-09'),
    (118,2,1007,'2018-10-25','2018-11-09'),
    (119,2,1007,'2018-10-25','2018-11-09'),
    (105,4,1008,'2018-11-02','2018-11-17'),
    (110,4,1008,'2018-11-02','2018-11-17'),
    (111,4,1008,'2018-11-02','2018-11-17'),
    (112,4,1008,'2018-10-16','2018-10-31'),
    (113,4,1008,'2018-10-16','2018-10-31'),
    (120,4,1008,'2018-10-27','2018-11-11'),
    (121,4,1008,'2018-10-27','2018-11-11'),
    (122,4,1008,'2018-10-28','2018-11-12')
;
GO

/* ----------------------------------------------
-------------------------------------------------
Create Procedures
-------------------------------------------------
---------------------------------------------- */


-- Question 1, Question 2
-- Create procedure that will return the number of copies of a particular book at a particular library branch.
CREATE PROCEDURE dbo.numBookCopies @ui_branchName VARCHAR(100) = '%', @ui_title VARCHAR(200) = '%'
AS
SELECT 
    a2.books_title AS 'Book Title', a3.libraryBranch_branchName AS 'Branch Name', a1.bookCopies_numberOfCopies AS 'Number of Copies'
    FROM tbl_bookCopies a1
    INNER JOIN tbl_books a2 ON a2.books_bookID = a1.bookCopies_bookID
    INNER JOIN tbl_libraryBranch a3 ON a3.libraryBranch_branchID = a1.bookCopies_branchID
    WHERE a2.books_title LIKE @ui_title AND a3.libraryBranch_branchName LIKE @ui_branchName
;
GO 

-- Question 1
EXECUTE dbo.numBookCopies @ui_branchName = 'Sharpstown', @ui_title = 'The Lost Tribe'
-- Question 2 
EXECUTE dbo.numBookCopies @ui_title='The Lost Tribe'
GO

-- -- Question 3
-- -- Retrieve the names of all borrowers who do not have any books checked out.
CREATE PROCEDURE dbo.noBooksCheckedOut 
AS
SELECT 
    borrower_name AS 'Borrower Name'
    FROM tbl_borrower
    WHERE borrower_cardNo NOT IN (SELECT 
    DISTINCT bookLoans_cardNo 
    FROM tbl_bookLoans)
;
GO
EXECUTE dbo.noBooksCheckedOut
GO


-- Question 4
-- Retrieve book title, borrow's name and address of all books from a given branch that is due on specified date.
CREATE PROCEDURE dbo.booksDue @ui_branchName VARCHAR(100) = '%', @ui_dueDate DATE
AS
SELECT 
    a2.bookLoans_dateDue AS 'Due Date', a4.libraryBranch_branchName AS 'Branch Name', a3.books_title AS 'Book Title', a1.borrower_name AS 'Borrower Name', a1.borrower_address AS 'Borrower Address'
    FROM tbl_borrower a1
    INNER JOIN tbl_bookLoans a2 ON a1.borrower_cardNo = a2.bookLoans_cardNo
    INNER JOIN tbl_books a3 ON a3.books_bookID = a2.bookLoans_bookID
    INNER JOIN tbl_libraryBranch a4 ON a2.bookLoans_branchID = a4.libraryBranch_branchID
    WHERE a4.libraryBranch_branchName LIKE @ui_branchName AND a2.bookLoans_dateDue = @ui_dueDate
;
GO
EXECUTE dbo.booksDue @ui_branchName = 'Sharpstown', @ui_dueDate = '2018-10-31'
GO


-- Question 5
-- For each library branch, retrieve branch name and total number of books loaned out from branch. 
CREATE PROCEDURE dbo.numBooksLoaned
AS
SELECT 
    a1.libraryBranch_branchName AS 'Branch Name', count(*) AS 'Total Books Loaned'
    FROM tbl_libraryBranch a1
    INNER JOIN tbl_bookLoans a2 ON a2.bookLoans_branchID = a1.libraryBranch_branchID
    GROUP BY a1.libraryBranch_branchName
;
GO
EXECUTE dbo.numBooksLoaned
GO


-- Question 6
-- Retrieve names, addresses, and number of books checked out for all borred > 5 books
CREATE PROCEDURE dbo.loansGreaterThan @ui_numBooks INT = '0'
AS
SELECT 
    count(*) AS 'Total Books Checked Out', tbl_borrower.borrower_name AS 'Name', tbl_borrower.borrower_address AS 'Address'
    FROM tbl_bookLoans 
    INNER JOIN tbl_borrower ON tbl_borrower.borrower_cardNo = tbl_bookLoans.bookLoans_cardNo
    GROUP BY tbl_borrower.borrower_name, tbl_borrower.borrower_address
    HAVING COUNT(*) > @ui_numBooks
;
GO
EXECUTE dbo.loansGreaterThan @ui_numBooks = 5
GO


-- Question 7
-- For each book by a given author / co-author, return title and number of copies owned by a specified branch
CREATE PROCEDURE dbo.findAuthorBooks @ui_author VARCHAR(200), @ui_branchName VARCHAR(200) = '%'
AS
SELECT
    a3.books_title AS 'Title', a4.bookAuthors_authorName AS 'Author', a2.libraryBranch_branchName AS 'Branch Name', a1.bookCopies_numberOfCopies AS 'Number Owned'
    FROM tbl_bookCopies a1
    INNER JOIN tbl_libraryBranch a2 ON a2.libraryBranch_branchID = a1.bookCopies_branchID
    INNER JOIN tbl_books a3 ON a3.books_bookID = a1.bookCopies_bookID
    INNER JOIN tbl_bookAuthors a4 ON a4.bookAuthors_bookID = a3.books_bookID
    WHERE a4.bookAuthors_authorName LIKE '%' + @ui_author + '%' AND a2.libraryBranch_branchName LIKE @ui_branchName
;
GO
EXECUTE dbo.findAuthorBooks @ui_author='Stephen King', @ui_branchName = 'Central'
GO