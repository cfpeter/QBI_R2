SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <01/22/2016>
-- Description:	<mass search for all business, product, and customer related tables>
-- =============================================
CREATE PROCEDURE [Business].[uspSearch]
	@SearchKey varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- UPDATEd Shirak Avakian 8/26/2016 to include all kind of search not only prospects
	SELECT 
	  cust.[CustomerID]		
	  ,isnull(cust.[CustomerTypeID],0) CustomerTypeID
	  ,isnull(cust.[PersonID],0) PersonID
	  ,isnull(o.[OrganizationID],0) OrganizationID
	  ,isnull(ot.[OrganizationTypeID],0) OrganizationTypeID
	--  ,isnull(p.ProductID,0) ProductID
	--  ,isnull(pt.ProductTypeID,0) ProductTypeID
	--  ,isnull(pst.ProductSubTypeID,0) ProductSubTypeID
	  ,isNull(ent.EntityID, 0 ) EntityID
	  --,l.[UserName]	  
	  ,custt.[Name] CustomerType	
	  ,(CASE WHEN( per.FirstName is NULL or per.FirstName = ''  ) THEN ent.Name ELSE per.[FirstName] + ' ' + per.[LastName] END ) As fullName
	  ,per.[FirstName]
	  ,per.[LastName]
	  ,per.Email
	  ,per.[DateOfBirth]
	  ,per.[Gender]
	--  ,p.Name ProductName
	--  ,p.Name + '-' + pt.Name productNameType
	--  ,pt.Name ProductType
	--  ,pst.Name ProductSubType
	  ,o.[Name] + ' ' + ot.Name organizationNameType
	  ,o.[Name] OrganizationName
	  ,ot.[Name] OrganizationType
	  ,csm.Supervisor_PersonID supervisorID
	  ,csm.CustomerID customerIDForSupervisor

	-- FROM [Customer].[Customer] cust (NOLOCK)  
	 FROM [Customer].[Customer] cust
	 INNER JOIN [Definition].CustomerType (NOLOCK) custt ON cust.CustomerTypeID = custt.CustomerTypeID
	 LEFT JOIN [Customer].[Person] per ON cust.PersonID = per.PersonID
	 LEFT JOIN [Map].[CustomerSupervisorMap] csm ON cust.CustomerID = csm.CustomerID 
	 LEFT JOIN [Customer].[Person] sup ON csm.Supervisor_PersonID = sup.PersonID
	 LEFT JOIN [Customer].[Entity] ent (NOLOCK) ON cust.EntityID = ent.EntityID
	 LEFT JOIN [Customer].[OrganizationBranch] ob (NOLOCK) ON per.OrganizationBranchID = ob.OrganizationBranchID
	 LEFT JOIN [Customer].[Organization] o (NOLOCK) on ob.OrganizationID = o.OrganizationID
	 LEFT JOIN [Definition].[OrganizationType] ot (NOLOCK) ON o.OrganizationTypeID = ot.OrganizationTypeID
	-- LEFT JOIN [Business].[Product] p (NOLOCK) ON cust.CustomerID = p.CustomerID	
	-- LEFT JOIN [Map].[ProductTypeMap] ptm (NOLOCK) ON p.ProductTypeMapID = ptm.ProductTypeMapID
	-- LEFT JOIN [Definition].[ProductType] pt (NOLOCK) ON ptm.ProductTypeID = pt.ProductTypeID
	-- LEFT JOIN [Definition].[ProductSubType] pst (NOLOCK) ON ptm.ProductSubTypeID = pst.ProductSubTypeID

	--LEFT JOIN [Map].[CustomerSupervisorMap] ON per.PersonID = csm.Supervisor_PersonID


	WHERE (per.FirstName like ('%' + @SearchKey + '%' )
	OR per.LastName Like( '%' + @SearchKey + '%' )
	OR per.Email Like( '%' + @SearchKey + '%' )
	OR ent.CallerEmail Like( '%' + @SearchKey + '%' )
	OR ent.CallerName Like( '%' + @SearchKey + '%' )
	OR ent.CallerPhone Like( '%' + @SearchKey + '%' )
	OR ent.Name Like( '%' + @SearchKey + '%' )
	OR o.Name Like( '%' + @SearchKey + '%' )
	--OR p.Name Like( '%' + @SearchKey + '%' )
	--OR p.Number Like( '%' + @SearchKey + '%' )
	--OR pt.Name Like( '%' + @SearchKey + '%' )
	--OR pst.Name Like( '%' + @SearchKey + '%' )
	)
	AND cust.IsActive = 1

  
END







GO
