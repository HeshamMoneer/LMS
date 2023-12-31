CREATE DATABASE $(DB_NAME);
GO

USE $(DB_NAME);
GO

CREATE TABLE Book (
  ISBN VARCHAR(13) PRIMARY KEY,
  Title VARCHAR(255) NOT NULL UNIQUE,
  Author VARCHAR(255) NOT NULL,
  Quantity INT,
  Shelf_Number INT,
  CONSTRAINT CK_Book_Quantity CHECK (Quantity >= 0)
);
GO

CREATE INDEX idx_Book_Title ON Book(Title);
GO
CREATE INDEX idx_Book_Author ON Book(Author);
GO

CREATE TABLE Borrower (
  Email VARCHAR(50) PRIMARY KEY,
  Name VARCHAR(255),
  Registered_Date DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Borrow (
  ISBN VARCHAR(13),
  Email VARCHAR(50),
  Quantity INT,
  Borrow_Date DATETIME DEFAULT GETDATE(),
  Due_Date DATETIME,
  PRIMARY KEY (ISBN, Email),
  FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
  FOREIGN KEY (Email) REFERENCES Borrower(Email),
  CONSTRAINT CK_Borrow_Quantity CHECK (Quantity > 0),
  CONSTRAINT CK_Borrow_Dates CHECK (Due_Date >= Borrow_Date)
);
GO