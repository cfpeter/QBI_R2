SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:    <Hamlet Tamazian>
-- Create date: <09/20/2017>
-- Description: <List all Kronos managers that recently signed up>
-- =============================================
CREATE PROCEDURE [Customer].[uspListKronosManagersRecentlySigned] 
  
AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.
  SET NOCOUNT ON;

    -- Insert statements for procedure here

  DECLARE @statusID int 			= ( SELECT statusID FROM [definition].[Status] WHERE Name = 'Active' )
  DECLARE @statusGroupID int		= ( SELECT statusGroupID FROM [definition].[StatusGroup] WHERE Name = 'Customer' )
  DECLARE @statusGroupMapID int		= ( SELECT statusGroupMapID FROM [Map].[StatusGroupMap] WHERE StatusID = @statusID AND StatusGroupID = @statusGroupID )
  --PRINT @statusGroupMapID

	SELECT
		 tpm.*
		,tpm.OneLoginUserID ReferenceID
		, p.FirstName 
		, p.LastName
		, p.Email
		, ob.Name CompanyName
		, c.MainClient
		, cl.IsActive LoginIsActive
		, cl.UpdatedDateTime LoginUpdatedDateTime
	FROM [Map].[ThirdPartyProviderMap] tpm

	INNER JOIN [Customer].[Customer] c on tpm.CustomerID = c.CustomerID 
	INNER JOIN [customer].[Person] p on c.PersonID = p.PersonID
	INNER JOIN [Customer].[OrganizationBranch] ob on p.OrganizationBranchID = ob.OrganizationBranchID
	INNER JOIN [Customer].[Login] cl on cl.CustomerID = c.CustomerID

	WHERE c.StatusGroupMapID = @statusGroupMapID 
	AND tpm.ThirdPartyProviderID = ( SELECT ThirdPartyProviderID from [Definition].[ThirdPartyProvider] where name = 'kronos' )
	AND p.PersonTitleTypeID = (SELECT PersonTitleTypeID FROM [Definition].[PersonTitleType] WHERE Name = 'Manager')
	AND (SELECT CONVERT(DATETIME, tpm.CreatedDateTime) ) > (SELECT DATEADD(m, -1, CURRENT_TIMESTAMP))
	 






  
END




GO
