CREATE PROCEDURE [dbo].[InsertEmployeeInfo]
  @EmployeeName NVARCHAR(100) = NULL,
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @CompanyName NVARCHAR(20),
    @Position NVARCHAR(30) = NULL,
    @Street NVARCHAR(50),
    @City NVARCHAR(20) = NULL,
    @State NVARCHAR(50) = NULL,
    @ZipCode NVARCHAR(50) = NULL
AS
BEGIN

    IF((COALESCE(NULLIF(LTRIM(RTRIM(@EmployeeName)), ''), '') IS NULL) AND (COALESCE(NULLIF(LTRIM(RTRIM(@FirstName)), ''), '') IS NULL) AND (COALESCE(NULLIF(LTRIM(RTRIM(@LastName)), ''), '') IS NULL))
    BEGIN
        RAISERROR('At least one of EmployeeName, FirstName, or LastName should be provided and not be empty or contain only spaces.', 16, 1)
        RETURN;
    END

   
    SET @CompanyName = LEFT(@CompanyName, 20);

  
    INSERT INTO [dbo].[Employee] (
        [AddressId],
        [PersonId],
        [CompanyName],
        [Position],
        [EmployeeName]
    )
    VALUES (
        (
            SELECT [Id]
            FROM [dbo].[Address]
            WHERE [Street] = @Street
              AND [City] = COALESCE(NULLIF(LTRIM(RTRIM(@City)), ''), [City])
              AND [State] = COALESCE(NULLIF(LTRIM(RTRIM(@State)), ''), [State])
              AND [ZipCode] = COALESCE(NULLIF(LTRIM(RTRIM(@ZipCode)), ''), [ZipCode])
        ),
        (
            SELECT [Id]
            FROM [dbo].[Person]
            WHERE [FirstName] = COALESCE(NULLIF(LTRIM(RTRIM(@FirstName)), ''), [FirstName])
              AND [LastName] = COALESCE(NULLIF(LTRIM(RTRIM(@LastName)), ''), [LastName])
        ),
        @CompanyName,
        @Position,
        @EmployeeName
    );

END;
