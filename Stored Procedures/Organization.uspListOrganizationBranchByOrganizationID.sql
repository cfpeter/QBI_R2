SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <3/15/2017>
-- Description:	<list organization branch, by given organizationID>
-- =============================================
CREATE PROCEDURE [Organization].[uspListOrganizationBranchByOrganizationID] 
	@OrganizationID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT /*cust.CustomerID
		  ,per.PersonID
		  ,*/ob.*

	  FROM [Customer].[OrganizationBranch] ob 
	  INNER JOIN [Customer].[Organization] org ON ob.OrganizationID = org.OrganizationID
	 /* LEFT JOIN [Customer].[Person] per ON ob.OrganizationBranchID = per.OrganizationBranchID
	  LEFT JOIN [Customer].[Customer] cust ON per.PersonID = cust.PersonID*/
	  LEFT JOIN [Definition].[OrganizationType] orgT ON org.OrganizationTypeID = orgT.OrganizationTypeID

	  WHERE org.OrganizationID = @OrganizationID
END




GO
