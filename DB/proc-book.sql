CREATE OR ALTER PROCEDURE CreateBook
    @ISBN VARCHAR(13),
    @Title VARCHAR(255),
    @Author VARCHAR(255),
    @Quantity INT = 0,
    @Shelf_Number INT = 0
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        RAISERROR('Book already exists', 16, 1)
        RETURN;
    END;

    INSERT INTO Book (ISBN, Title, Author, Quantity, Shelf_Number)
    VALUES (@ISBN, @Title, @Author, @Quantity, @Shelf_Number);
END
GO

CREATE OR ALTER PROCEDURE ReadBook
    @ISBN VARCHAR(13)
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        RAISERROR('Book not found', 16, 1)
        RETURN;
    END;

    SELECT * FROM Book
    WHERE ISBN=@ISBN;
END
GO


CREATE OR ALTER PROCEDURE UpdateBook
    @ISBN VARCHAR(13),
    @Title VARCHAR(255) = NULL,
    @Author VARCHAR(255) = NULL,
    @Quantity INT = NULL,
    @Shelf_Number INT = NULL
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        RAISERROR('Book not found', 16, 1)
        RETURN;
    END;

    UPDATE Book
    SET
        Title = ISNULL(@Title, Title),
        Author = ISNULL(@Author, Author),
        Quantity = ISNULL(@Quantity, Quantity),
        Shelf_Number = ISNULL(@Shelf_Number, Shelf_Number)
    WHERE ISBN = @ISBN;
END
GO

CREATE OR ALTER PROCEDURE DeleteBook
    @ISBN VARCHAR(13)
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        RAISERROR('Book not found', 16, 1)
        RETURN;
    END;

    DELETE FROM Book
    WHERE ISBN = @ISBN;
END
GO

CREATE OR ALTER PROCEDURE GetAllBooks
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    SELECT * FROM Book;
END
GO

CREATE OR ALTER PROCEDURE SearchBookTitle
    @Key VARCHAR(255)
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    SELECT *
    FROM Book
    WHERE Title LIKE @Key + '%';
END
GO

CREATE OR ALTER PROCEDURE SearchBookAuthor
    @Key VARCHAR(255)
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    SELECT *
    FROM Book
    WHERE Author LIKE @Key + '%';
END
GO

CREATE OR ALTER PROCEDURE SearchBookISBN
    @Key VARCHAR(255)
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    SELECT *
    FROM Book
    WHERE ISBN LIKE @Key + '%';
END
GO