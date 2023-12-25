CREATE TRIGGER trg_CreateCompanyOnEmployeeInsert
ON [dbo].[Employee]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @EmployeeId INT, @CompanyName NVARCHAR(20), @AddressId INT;

    SELECT @EmployeeId = Id, @CompanyName = CompanyName
    FROM INSERTED;

    SELECT @AddressId = E.AddressId
    FROM [dbo].[Employee] E
    WHERE E.Id = @EmployeeId;

    INSERT INTO [dbo].[Company] ([Name], [AddressId])
    SELECT @CompanyName, @AddressId
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dbo].[Company] C
        WHERE C.Name = @CompanyName
    );
END;