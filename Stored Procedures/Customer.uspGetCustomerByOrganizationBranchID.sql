SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <03/16/2017>
-- Updated Date <05/11/2017> by Shirak Avakian
-- Description:	<Get Customer Info for given OrganizationBranchID>
-- =============================================
CREATE PROCEDURE [Customer].[uspGetCustomerByOrganizationBranchID] 
	@OrganizationBranchID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT cust.*
	FROM [Customer].[Customer] cust
	INNER JOIN [Customer].[Person] per on cust.PersonID = per.PersonID
	INNER JOIN [Customer].[OrganizationBranch] ob ON per.OrganizationBranchID = ob.OrganizationBranchID
	WHERE ob.OrganizationBranchID = @OrganizationBranchID
	AND cust.IsPrimary = 1
	AND cust.MainClient = 1
END


GO
