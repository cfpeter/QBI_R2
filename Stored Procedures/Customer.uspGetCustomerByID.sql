SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <02/04/2016>
-- Description:	<Get customer by given customer ID>
-- =============================================
CREATE PROCEDURE [Customer].[uspGetCustomerByID] 
	-- Add the parameters for the stored procedure here
	 @CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Distinct(cust.CustomerID)
	  ,cust.[CustomerTypeID]
	  ,cust.CRMClientID 
	  ,cust.CRMContactID 
	  ,cust.IsPrimary 
	  ,cust.VerificationCode
      ,cust.MainClient -- added by SA 04/07/2017
      ,cl.IsActive LoginIsActive -- added by Hamlet 11/8/17
	  ,p.[PersonID]
	  ,ent.EntityID
	  ,p.[PrefixTypeID]
	  ,pertt.[PersonTitleTypeID]
	  ,o.[OrganizationID]
	  ,ot.[OrganizationTypeID]
	  ,ob.OrganizationBranchID
	  ,ent.ProductTypeMapID
	  ,cust.StatusGroupMapID
	  ,st.StatusID
	  ,st.Name StatusName
	  ,custt.[Name] CustomerTypeName  
	  ,cust.CreatedDateTime
	  ,cust.UpdatedDateTime
	  ,cust.CreatedBy
	  ,cust.UpdatedBy	 
	  ,p.[FirstName]
	  ,p.[LastName]
	  ,p.[DateOfBirth]
	  ,p.[Gender]
	  ,p.[Email]	  
	  ,p.[SSN]
	  ,p.[SSNKEY]
	  ,p.DistributeTo
	  ,pertt.[Name] PersonTitleName	  	  
	  ,ot.Name OrganizationType
	  ,o.[Name] OrganizationName
	  ,ot.[Name] OrganizationType	  
	  ,ob.Name OrganizationBranchName
	  ,ent.Name EntityName
	  ,ent.CallerName CallerName
	  ,ent.CallerPhone CallerPhone
	  ,ent.CallerEmail CallerPhone
	  ,ph.PhoneID phoneNumberID
	  ,ph.Number phoneNumber
	   ,ph.PhoneTypeID
	   ,pt.name phoneTypeName
	 FROM [Customer].[Customer] cust 
	 INNER JOIN [Definition].CustomerType custt ON cust.CustomerTypeID = custt.CustomerTypeID
	 INNER JOIN [Map].[StatusGroupMap] sgm ON cust.StatusGroupMapID = sgm.StatusGroupMapID
	 INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
	-- INNER JOIN Map.CustomerSupervisorMap csm ON cust.CustomerID = csm.CustomerID
	-- INNER JOIN Customer.Person sup ON csm.Supervisor_PersonID = sup.PersonID
	 LEFT JOIN Customer.Person p ON cust.PersonID = p.PersonID
	 LEFT JOIN [Customer].[Login] cl ON cl.CustomerID = cust.CustomerID
	 LEFT JOIN [Definition].[PersonTitleType]  pertt ON p.PersonTitleTypeID = pertt.PersonTitleTypeID
	 LEFT JOIN [Customer].[Entity] ent ON cust.EntityID = ent.EntityID
	-- LEFT JOIN [Definition].PersonTitleType supt ON sup.PersonTitleTypeID = supt.PersonTitleTypeID
	/* LEFT JOIN [Definition].[SuffixType] suft ON p.SuffixTypeID = suft.SuffixTypeID
	 LEFT JOIN [Definition].[EntityType] entt ON ent.EntityTypeID = ent.EntityTypeID */
	 LEFT JOIN [Customer].[OrganizationBranch] ob ON p.OrganizationBranchID = ob.OrganizationBranchID
	 LEFT JOIN [Customer].[Organization] o on ob.OrganizationID = o.OrganizationID
	 LEFT JOIN [Definition].[OrganizationType] ot ON o.OrganizationTypeID = ot.OrganizationTypeID
	 LEFT JOIN [Map].[PersonPhoneMap] ppm on p.PersonID = ppm.PersonID
	LEFT JOIN [Customer].[Phone] ph	ON ppm.PhoneID = ph.PhoneID

	  LEFT JOIN [Definition].[PhoneType] pt ON ph.PhoneTypeID = pt.PhoneTypeID
	WHERE cust.CustomerID = @CustomerID
	AND cust.IsActive = 1
	Order by cust.UpdatedDateTime DESC
END







GO
