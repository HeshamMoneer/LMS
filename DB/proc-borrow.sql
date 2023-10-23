CREATE OR ALTER PROCEDURE BorrowBook
  @ISBN VARCHAR(13),
  @Email VARCHAR(50),
  @Quantity INT = 1,
  @Due_Date DATETIME = NULL
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        RAISERROR('Book not found', 16, 1)
        RETURN;
    END;

    IF NOT EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR('Borrower not found', 16, 1)
        RETURN;
    END;

    IF (SELECT Quantity FROM Book WHERE ISBN = @ISBN) < @Quantity
    BEGIN
        RAISERROR('Not enough copies', 16, 1)
        RETURN;
    END;

    IF EXISTS (SELECT 1 FROM Borrow WHERE Email = @Email AND ISBN = @ISBN)
    BEGIN
        UPDATE Borrow
        SET Quantity = Quantity + @Quantity,
            Due_Date = ISNULL(@Due_Date, Due_Date)
        WHERE Email = @Email AND ISBN = @ISBN
    END;
    ELSE
    BEGIN
        INSERT INTO Borrow (ISBN, Email, Quantity, Due_Date)
        VALUES (@ISBN, @Email, @Quantity, ISNULL(@Due_Date, DATEADD(DAY, 14, GETDATE())));
    END;

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
    SET XACT_ABORT, NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        RAISERROR('Book not found', 16, 1)
        RETURN;
    END;

    IF NOT EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR('Borrower not found', 16, 1)
        RETURN;
    END;

    IF NOT EXISTS (SELECT 1 FROM Borrow WHERE ISBN = @ISBN AND Email = @Email)
    BEGIN
        RAISERROR('User did not borrow this book', 16, 1)
        RETURN;
    END;

    DECLARE @Quantity INT;
    SET @Quantity = (SELECT Quantity FROM Borrow WHERE ISBN = @ISBN AND Email = @Email);

    DELETE FROM Borrow 
    WHERE Email = @Email AND ISBN = @ISBN;

    UPDATE Book
    SET Quantity = Quantity + @Quantity
    WHERE ISBN = @ISBN;

END;
GO


CREATE OR ALTER PROCEDURE GetMyBooks
  @Email VARCHAR(50)
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR('Borrower not found', 16, 1)
        RETURN;
    END;

    SELECT * FROM Borrow
    WHERE Email = @Email;
END;
GO


CREATE OR ALTER PROCEDURE GetOverdueBorrows
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    SELECT * FROM Borrow
    WHERE Borrow.Due_Date < GETDATE()
END;
GO