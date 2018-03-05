SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Organization].[uspListOrganizationBranchByOrganizationBranchID]
@OrganizationBranchID int 

AS
BEGIN
	
   SELECT 
		cust.CustomerID
		,cust.IsPrimary	
		,per.PersonID
		,ob.*

	  FROM [Customer].[OrganizationBranch] ob 
	  INNER JOIN [Customer].[Organization] org ON ob.OrganizationID = org.OrganizationID
	  LEFT JOIN [Customer].[Person] per ON ob.OrganizationBranchID = per.OrganizationBranchID
	  LEFT JOIN [Customer].[Customer] cust ON per.PersonID = cust.PersonID
	  LEFT JOIN [Definition].[OrganizationType] orgT ON org.OrganizationTypeID = orgT.OrganizationTypeID

	  WHERE per.OrganizationBranchID = @OrganizationBranchID
	 
	 
END










GO
