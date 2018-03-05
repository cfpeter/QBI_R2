SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <12/28/2015>
-- Description:	<Get current customer identity (Customer info, login info, organization info>
-- =============================================
CREATE PROCEDURE [Security].[uspGetCustomerIdentity] 
	@UserName varchar(50)
	--@Password varchar(150)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @LoginID int

	SELECT l.[LoginID]
	  ,l.[CustomerID]
	  ,cust.[PersonID]
	  ,cust.[CustomerTypeID]
	  ,per.[PersonTitleTypeID]
	  ,per.[PrefixTypeID]
	  ,entt.[EntityTypeID]
	  ,o.[OrganizationID]
	  ,ot.[OrganizationTypeID]
	  ,ob.OrganizationBranchID
	  ,csm.CustomerSupervisorMapID
	  ,dept.DepartmentID
	  ,cust.CRMClientID
	  ,cust.CRMContactID
	  ,cust.ReferenceID
	  ,csm.Supervisor_CustomerID 
	  ,csm.Supervisor_PersonID 
	  ,l.[UserName]
	  ,l.[PassCode]
	  ,l.[salt]	  
	  ,custt.[Name] CustomerTypeName	 
	  ,per.[FirstName]
	  ,per.[LastName]	
	  ,per.[Email]	  
	  ,pertt.[Name] PersonTitleName
	  ,per.[DateOfBirth]
	  ,per.[Gender]	 
	  ,pft.[Name] prefix
 	  ,ent.[EntityID]
	  ,ent.Name EntityName 
	  ,entt.[Name] EntityTypeName  
	  ,ot.Name OrganizationType
	  ,o.[Name] OrganizationName
	  ,ot.[Name] OrganizationType 
	  ,ob.Name OrganizationBranchName
	  ,ob.PhoneNumber
	  ,ob.FaxNumber
	  ,cust.IsPrimary
	  ,cust.CreatedDateTime
	  ,cust.UpdatedDateTime
	  ,cust.CreatedBy
	  ,cust.UpdatedBy
	
	  ,dept.Name Department
	 FROM [Customer].[Login] l 
	 LEFT JOIN [Customer].[Customer] cust ON l.CustomerID = cust.CustomerID
	 LEFT JOIN [Map].CustomerSupervisorMap csm on cust.CustomerID = csm.CustomerID
	 LEFT JOIN [Definition].CustomerType custt ON cust.CustomerTypeID = custt.CustomerTypeID
	 LEFT JOIN [Customer].[Person] per ON cust.PersonID = per.PersonID
	 LEFT JOIN [Definition].[PersonTitleType]  pertt ON per.PersonTitleTypeID = pertt.PersonTitleTypeID
	 LEFT JOIN [Definition].[PrefixType] pft ON per.PrefixTypeID = pft.prefixTypeID
	 LEFT JOIN [Customer].[Entity] ent ON cust.EntityID = ent.EntityID
	 LEFT JOIN [Definition].[EntityType] entt ON ent.EntityTypeID = ent.EntityTypeID 
	 LEFT JOIN [Customer].[OrganizationBranch] ob ON per.OrganizationBranchID = ob.OrganizationBranchID
	 LEFT JOIN [Customer].[Organization] o on ob.OrganizationID = o.OrganizationID
	 LEFT JOIN [Definition].[OrganizationType] ot ON o.OrganizationTypeID = ot.OrganizationTypeID
	 LEFT JOIN [Definition].Department dept on per.DepartmentID = dept.DepartmentID
	WHERE l.[UserName] = @UserName
	--AND l.[PassCode] = @Password
	AND l.[IsActive] = 1

	SET @LoginID = (SELECT LoginID FROM [Customer].[Login] WHERE UserName = @UserName)

	UPDATE [Customer].[Login]
	SET LastLoginDateTime = CURRENT_TIMESTAMP
	WHERE LoginID = @LoginID


END













GO
