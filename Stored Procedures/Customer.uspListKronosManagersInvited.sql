SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <09/20/2017>
-- Description:	<List all Invited Kronos managers from temp>
-- =============================================
CREATE PROCEDURE [Customer].[uspListKronosManagersInvited] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @statusID int 				= ( SELECT statusID FROM [definition].[Status] WHERE Name = 'Signup Invitation Pending' )
	DECLARE @statusGroupID int			= ( SELECT statusGroupID FROM [definition].[StatusGroup] WHERE Name = 'Customer' )
	DECLARE @statusGroupMapID int		= ( SELECT statusGroupMapID FROM [Map].[StatusGroupMap] WHERE StatusID = @statusID AND StatusGroupID = @statusGroupID ) 

	SELECT 
		  tpm.*
		, p.FirstName 
		, p.LastName
		, p.Email
		, ob.Name CompanyName 
	FROM [Map].[ThirdPartyProviderMap] tpm 

	INNER JOIN [Customer].[Customer] c on tpm.CustomerID = c.CustomerID 
	INNER JOIN [customer].[Person] p on c.PersonID = p.PersonID
	INNER JOIN [Customer].[OrganizationBranch] ob on p.OrganizationBranchID = ob.OrganizationBranchID

	WHERE c.StatusGroupMapID = @statusGroupMapID 
	AND tpm.ThirdPartyProviderID = ( SELECT ThirdPartyProviderID from [Definition].[ThirdPartyProvider] where name = 'kronos' )
	AND p.PersonTitleTypeID = (SELECT PersonTitleTypeID FROM [Definition].[PersonTitleType] WHERE Name = 'Manager')
	 




END




GO
