SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <09/27/2016>
-- Description:	<get organization, organization branch, type>
-- =============================================
CREATE PROCEDURE [Organization].[uspGetOrganizationAndBranchByCustomer] 
	@CustomerID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT [CustomerID]	
		  ,cust.[PersonID]
		  ,org.OrganizationID
		  ,org.CompanyTypeID
		  ,ob.OrganizationBranchID -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.PayrollFrequencyID -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.PayrollProviderID -- Updated by Shirak release 1.4 02/10/2014
		  ,org.OrganizationTypeID
		  ,cust.[CRMContactID]
		  ,cust.[CRMClientID]
		  ,cust.[SalesPersonID]
		  ,cust.[IsPrimary]
		  ,p.FirstName
		  ,p.LastName
		  ,org.Name OrganizationName
		  ,org.[Union]
		  ,org.BusinessCode	 
		  ,org.AffiliatedGroup -- Updated by Shirak release 1.4 02/10/2014 ////  AffiliatedGroupID to AffiliatedGroup by peter 1.4 03/16/2017
		  ,org.ControlGroup
		  ,org.EIN
		  ,orgT.Name OrganizationTypeName
		  ,ob.Name OrganizationBranchName
		  ,ob.Email OrganizationBranchEmail
		  ,ob.PhoneNumber OrganizationBranchPhoneNumber
		  ,ob.FaxNumber OrganizationBranchFaxNumber
		  ,ob.FYEDay -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.FYEMonth -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.IRCSection -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.WeekStart -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.NatureOfBusiness -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.YearCoBegan -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.TotalEmployees -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.CreatedBy -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.CreatedDateTime -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.UpdatedBy -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.UpdatedDateTime -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.IsActive -- Updated by Shirak release 1.4 02/10/2014
		  ,ob.IsPrimaryBranch -- Updated by Shirak release 1.4 02/28/2014
		  ,ct.name CompanyTypeName -- Updated by Ken release 1.4 03/22/2017

	  FROM [Customer].[Customer] cust
	  INNER JOIN [Customer].[Person] p ON cust.PersonID = p.PersonID
	  INNER JOIN [Customer].[OrganizationBranch] ob ON p.OrganizationBranchID = ob.OrganizationBranchID
	  INNER JOIN [Customer].[Organization] org ON ob.OrganizationID = org.OrganizationID
	  LEFT JOIN [Definition].[OrganizationType] orgT ON org.OrganizationTypeID = orgT.OrganizationTypeID
	  LEFT JOIN [Definition].[CompanyType] ct ON org.CompanyTypeID = ct.CompanyTypeID -- Updated by Ken release 1.4 03/22/2017

	  WHERE cust.CustomerID = @CustomerID
END



GO
