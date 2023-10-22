CREATE OR ALTER PROCEDURE BorrowBook
  @ISBN VARCHAR(13),
  @Email VARCHAR(50),
  @Quantity INT = 1,
  @Due_Date DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        RAISERROR(9, -1, -1, 'Book not found')
        RETURN;
    END;

    IF NOT EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR(10, -1, -1, 'Borrower not found')
        RETURN;
    END;

    IF (SELECT Quantity FROM Book WHERE ISBN = @ISBN) < @Quantity
    BEGIN
        RAISERROR(11, -1, -1, 'Not enough copies')
        RETURN;
    END;

    INSERT INTO Borrow (ISBN, Email, Quantity, Due_Date)
    VALUES (@ISBN, @Email, @Quantity, ISNULL(@Due_Date, DATEADD(DAY, 14, GETDATE())));

    UPDATE Book
    SET Quantity = Quantity - @Quantity
    WHERE ISBN = @ISBN;

END;
GO


CREATE OR ALTER PROCEDURE ReturnBook
  @ISBN VARCHAR(13),
  @Email VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        RAISERROR(12, -1, -1, 'Book not found')
        RETURN;
    END;

    IF NOT EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR(13, -1, -1, 'Borrower not found')
        RETURN;
    END;

    IF NOT EXISTS (SELECT 1 FROM Borrow WHERE ISBN = @ISBN AND Email = @Email)
    BEGIN
        RAISERROR(14, -1, -1, 'User did not borrow this book')
        RETURN;
    END;

    DECLARE @Quantity INT;
    SET @Quantity = (SELECT Quantity FROM Borrow WHERE ISBN = @ISBN AND Email = @Email);

    UPDATE Borrow 
    SET Quantity = 0,
        Return_Date = GETDATE()
    WHERE Email = @Email AND ISBN = @ISBN;

    UPDATE Book
    SET Quantity = Quantity + @Quantity
    WHERE ISBN = @ISBN;

END;
GO


CREATE OR ALTER PROCEDURE CheckMyBooks
  @Email VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR(15, -1, -1, 'Borrower not found')
        RETURN;
    END;

    SELECT * FROM Borrow
    WHERE Email = @Email;
END;
GO


CREATE OR ALTER PROCEDURE GetOverdueBorrows
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Borrow
    JOIN Borrower ON Borrow.Email = Borrower.Email
    JOIN Book ON Borrow.ISBN = Book.ISBN
    WHERE Borrow.Due_Date < GETDATE() AND Borrow.Return_Date = NULL
END;
GO