CREATE OR ALTER PROCEDURE CreateBorrower
    @Email VARCHAR(50),
    @Name VARCHAR(255)
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR('Borrower already exists', 16, 1)
        RETURN;
    END;

    INSERT INTO Borrower (Email, Name)
    VALUES (@Email, @Name);
END
GO

CREATE OR ALTER PROCEDURE ReadBorrower
    @Email VARCHAR(50)
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR('Borrower not found', 16, 1)
        RETURN;
    END;

    SELECT * FROM Borrower
    WHERE Email=@Email;
END
GO

CREATE OR ALTER PROCEDURE UpdateBorrower
    @Email VARCHAR(50),
    @Name VARCHAR(255)
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR('Borrower not found', 16, 1)
        RETURN;
    END;

    UPDATE Borrower
    SET
        Name = @Name
    WHERE Email = @Email;
END
GO


CREATE OR ALTER PROCEDURE DeleteBorrower
    @Email VARCHAR(13)
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR('Borrower not found', 16, 1)
        RETURN;
    END;

    DELETE FROM Borrower
    WHERE Email = @Email;
END
GO


CREATE OR ALTER PROCEDURE GetAllBorrowers
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    SELECT * FROM Borrower;
END
GO

