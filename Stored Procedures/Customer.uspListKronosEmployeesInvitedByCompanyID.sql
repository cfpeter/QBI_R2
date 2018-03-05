SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <09/20/2017>
-- Description:	<List all Kronos employees from temp that have been invited>

-- =============================================
CREATE PROCEDURE [Customer].[uspListKronosEmployeesInvitedByCompanyID] 
	@CompanyID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @statusID int 				= ( SELECT statusID FROM [definition].[Status] WHERE Name = 'Signup Invitation Pending' )
	DECLARE @statusGroupID int			= ( SELECT statusGroupID FROM [definition].[StatusGroup] WHERE Name = 'Customer' )
	DECLARE @statusGroupMapID int		= ( SELECT statusGroupMapID FROM [Map].[StatusGroupMap] WHERE StatusID = @statusID AND StatusGroupID = @statusGroupID )
	--PRINT @statusGroupMapID
	--DECLARE @CompanyID bigint = 6886403

	/*SELECT [KronosQBIClientID]
      ,kqc.[AccountID]
      ,kqc.[CompanyID]
      ,[EmployeeID]
      ,[AccountStatus]
      ,[CompanyName]
      ,[CompanyShortName]
      ,[CompanyType]
      ,[EIN]
      ,[Created]
      ,[Email]
      ,kqc.[ExternalID]
      ,[FirstName]
      ,[LastName]
      ,[Locked]
      ,[SecurityProfile]
      ,[Username]
      ,[ImportedAsQBIClient]
      ,[CreateDateTime]
      ,kqc.[CreatedBy]
      ,kqc.[UpdatedDateTime]
      ,kqc.[UpdatedBy]
      ,kqc.[Note]
  FROM [Temp].[KronosQBIClient] kqc
  INNER JOIN [Map].[ThirdPartyProviderMap] tpp ON kqc.AccountID = tpp.AccountID 
  INNER JOIN [Customer].[Customer] c ON tpp.CustomerID = c.CustomerID
  WHERE SecurityProfile LIKE 'Employee'
  AND	tpp.CompanyID = 211137
  AND	c.StatusGroupMapID = @statusGroupMapID*/

  	SELECT   
		tpp.*
		, p.FirstName 
		, p.LastName
		, p.Email
		-- , ob.Name CompanyName
		,c.[CustomerID]
		-- ,ct.Name customerTypeName
		,c.[ReferenceID]
		,p.OrganizationBranchID
		-- ,o.OrganizationID

	FROM [Customer].[Customer] c
		INNER JOIN [Map].[ThirdPartyProviderMap] tpp ON c.customerID = tpp.customerID  
		INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID

	WHERE	CompanyID = @CompanyID
	AND p.PersonTitleTypeID			= ( SELECT personTitleTypeID FROM [Definition].[PersonTitleType] WHERE name = 'Employee' )
	AND tpp.ThirdPartyProviderID	= ( SELECT ThirdPartyProviderID FROM [Definition].[ThirdPartyProvider] WHERE name = 'Kronos' )
	AND	c.StatusGroupMapID			= @statusGroupMapID
 
END




GO
