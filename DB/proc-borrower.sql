CREATE OR ALTER PROCEDURE CreateBorrower
    @Email VARCHAR(50),
    @Name VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR(1, -1, -1, 'Borrower already exists')
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
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR(2, -1, -1, 'Borrower not found')
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
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR(3, -1, -1, 'Borrower not found')
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
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Borrower WHERE Email = @Email)
    BEGIN
        RAISERROR(4, -1, -1, 'Borrower not found')
        RETURN;
    END;

    DELETE FROM Borrower
    WHERE Email = @Email;
END
GO


CREATE OR ALTER PROCEDURE GetAllBorrowers
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Borrower;
END
GO

