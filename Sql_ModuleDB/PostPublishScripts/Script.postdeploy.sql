/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

IF NOT EXISTS (SELECT * from dbo.Person WHERE LastName = 'Bernard' AND FirstName = 'Andy')
BEGIN 
 INSERT INTO dbo.Person(FirstName, LastName)
 VALUES ('Andy', 'Bernard')

END

GO

IF NOT EXISTS (SELECT * from dbo.Address WHERE Street = 'Grow St' AND City = 'San Diego' AND State = 'California' AND ZipCode = '123' )
BEGIN
 INSERT INTO dbo.Address(Street, City, State, ZipCode)
 VALUES ('Grow St', 'San Diego', 'California', '123')
END

GO

IF NOT EXISTS (SELECT * from dbo.Employee WHERE AddressId = 1 AND PersonId = 1 AND CompanyName = 'Google' AND Position = 'SWE' AND EmployeeName = 'Andy')
BEGIN
    INSERT INTO dbo.Employee(PersonId, AddressId, CompanyName, Position, EmployeeName)
    VALUES (1, 1, 'Google', 'SWE', 'Andy')
END

GO

IF NOT EXISTS (SELECT * from dbo.Company WHERE Name = 'Google' AND AddressId = 1)
BEGIN
    INSERT INTO dbo.Company(Name, AddressId)
    VALUES ('Google', 1)
END