SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <1/3/2017>
-- Description:	<Get Organization by given customer ID>
-- =============================================
CREATE PROCEDURE [Organization].[uspGetOrganizationByCustomer] 
	@CustomerID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT org.*

	  FROM [Customer].[Customer] cust
	  INNER JOIN [Customer].[Person] p ON cust.PersonID = p.PersonID
	  INNER JOIN [Customer].[OrganizationBranch] ob ON p.OrganizationBranchID = ob.OrganizationBranchID
	  INNER JOIN [Customer].[Organization] org ON ob.OrganizationID = org.OrganizationID
	  LEFT JOIN [Definition].[OrganizationType] orgT ON org.OrganizationTypeID = orgT.OrganizationTypeID

	  WHERE cust.CustomerID = @CustomerID
END


GO
