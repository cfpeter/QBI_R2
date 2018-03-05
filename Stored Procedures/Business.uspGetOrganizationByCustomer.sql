SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <09/27/2016>
-- Description:	<get organization, organization branch, type, and address information>
-- =============================================
CREATE PROCEDURE [Business].[uspGetOrganizationByCustomer] 
	@CustomerID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT [CustomerID]	
		  ,cust.[PersonID]
		  ,org.OrganizationID
		  ,p.OrganizationBranchID
		  ,org.OrganizationTypeID
		  ,cust.[CRMContactID]
		  ,cust.[CRMClientID]
		  ,cust.[SalesPersonID]
		  ,cust.[IsPrimary]
		  ,p.FirstName
		  ,p.LastName
		  ,org.Name OrganizationName
		  ,orgT.Name OrganizationTypeName
		  ,ob.Name OrganizationBranchName
		  ,ob.Email OrganizationBranchEmail
		  ,ob.PhoneNumber OrganizationBranchPhoneNumber
		  ,ob.FaxNumber OrganizationBranchFaxNumber

	  FROM [Customer].[Customer] cust
	  INNER JOIN [Customer].[Person] p ON cust.PersonID = p.PersonID
	  INNER JOIN [Customer].[OrganizationBranch] ob ON p.OrganizationBranchID = ob.OrganizationBranchID
	  INNER JOIN [Customer].[Organization] org ON ob.OrganizationID = org.OrganizationID
	  LEFT JOIN [Definition].[OrganizationType] orgT ON org.OrganizationTypeID = orgT.OrganizationTypeID

	  WHERE cust.CustomerID = @CustomerID
END


GO
