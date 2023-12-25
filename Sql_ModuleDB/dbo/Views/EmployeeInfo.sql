CREATE VIEW [dbo].[EmployeeInfo]
	AS 
    SELECT
    E.Id AS EmployeeId,
    ISNULL(E.EmployeeName, P.FirstName + ' ' + P.LastName) AS EmployeeFullName,
    ISNULL(A.ZipCode, '') + '_' + ISNULL(A.State, '') + ', ' + ISNULL(A.City, '') + '-' + ISNULL(A.Street, '') AS EmployeeFullAddress,
    ISNULL(E.CompanyName, '') + '(' + ISNULL(E.Position, '') + ')' AS EmployeeCompanyInfo
FROM
    [dbo].[Employee] E
JOIN
    [dbo].[Person] P ON E.PersonId = P.Id
JOIN
    [dbo].[Address] A ON E.AddressId = A.Id
JOIN
    [dbo].[Company] C ON E.CompanyName = C.Name
ORDER BY 
    C.Name ASC,
    A.City ASC OFFSET 0 ROWS
    



