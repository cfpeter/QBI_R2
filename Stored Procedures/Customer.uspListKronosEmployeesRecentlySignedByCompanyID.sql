SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <09/20/2017>
-- Description:	<List all Kronos employees from temp that have recently signed up>

-- =============================================
CREATE PROCEDURE [Customer].[uspListKronosEmployeesRecentlySignedByCompanyID] 
	@CompanyID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @statusID int 				= ( SELECT statusID FROM [definition].[Status] WHERE Name = 'Active' )
	DECLARE @statusGroupID int			= ( SELECT statusGroupID FROM [definition].[StatusGroup] WHERE Name = 'Customer' )
	DECLARE @statusGroupMapID int		= ( SELECT statusGroupMapID FROM [Map].[StatusGroupMap] WHERE StatusID = @statusID AND StatusGroupID = @statusGroupID )
 
	  
	
	SELECT   
		tpp.*
		,tpp.OneLoginUserID ReferenceID
		, p.FirstName 
		, p.LastName
		, p.Email
		-- , ob.Name CompanyName
		,c.[CustomerID]
		,cl.IsActive
		-- ,ct.Name customerTypeName 
		,p.OrganizationBranchID
		-- ,o.OrganizationID

	FROM [Customer].[Customer] c
		INNER JOIN [Map].[ThirdPartyProviderMap] tpp ON c.customerID = tpp.customerID  
		INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
		INNER JOIN [Customer].[Login] cl on cl.CustomerID = c.CustomerID

	WHERE	CompanyID = @CompanyID
	AND p.PersonTitleTypeID			= ( SELECT personTitleTypeID FROM [Definition].[PersonTitleType] WHERE name = 'Employee' )
	AND tpp.ThirdPartyProviderID	= ( SELECT ThirdPartyProviderID FROM [Definition].[ThirdPartyProvider] WHERE name = 'Kronos' )
	AND	c.StatusGroupMapID			= @statusGroupMapID
	--AND c.IsActive = 1
	AND (SELECT CONVERT(DATETIME, tpp.CreatedDateTime) ) > (SELECT DATEADD(m, -1, CURRENT_TIMESTAMP))
 
END




GO
