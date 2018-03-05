SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <09/01/2017>
-- Description:	<List similar Advisors by given keyword. Used in type ahead>
-- =============================================
CREATE PROCEDURE [Customer].[uspListSimilarAdvisors] 
	@cid int,
	@keyword varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT c.CustomerID advisorCustomerID, c.CustomerTypeID,c.AdvisorTypeID, c.UpdatedDateTime, pn.PersonID, pn.OrganizationBranchID, pn.DepartmentID, pn.PersonTitleTypeID, pn.FirstName, pn.LastName, pn.DateOfBirth, pn.Gender, pn.Email, p.PhoneID, p.PhoneTypeID, p.Number, p.NumberExt   /*, a.**/
		FROM [Customer].[Customer] c
		INNER JOIN [Customer].[Person] pn ON pn.PersonID = c.PersonID
		/*LEFT JOIN [Customer].[Address] a ON a.AddressID = (SELECT pam.AddressID FROM [Map].[PersonAddress] pam WHERE pn.PersonID = pam.PersonID)*/
		LEFT JOIN [Customer].[Phone] p ON p.PhoneID = (SELECT ppm.PhoneID FROM [Map].[PersonPhoneMap] ppm WHERE pn.PersonID = ppm.PersonID)
		WHERE ( pn.FirstName LIKE (@keyword + '%') OR
			  pn.LastName LIKE (@keyword + '%') ) 
			  AND c.CustomerTypeID = (SELECT customerTypeID FROM [Definition].[CustomerType] WHERE name = 'Advisor')
			  AND c.CustomerID IN (SELECT pam.AdvisorCustomerID FROM [Map].[ProductAdvisorMap] pam WHERE pam.ProductID in ( SELECT pt.ProductID FROM [Business].[Product] pt WHERE pt.CustomerID = @cid ) )
			 
END

			


GO
