SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:    <Hamlet Tamazian>
-- Create date: <10/2/2017>
-- Description: <List all Kronos employees for typeahead>
-- =============================================
CREATE PROCEDURE [Customer].[uspTypeaheadKronosEmployeesSignedByCompanyID] 
  @CompanyID bigint,
  @keyword varchar(25)
AS
BEGIN
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @statusID int 			= ( SELECT statusID FROM [definition].[Status] WHERE Name = 'Active' )
	DECLARE @statusGroupID int		= ( SELECT statusGroupID FROM [definition].[StatusGroup] WHERE Name = 'Customer' )
	DECLARE @statusGroupMapID int		= ( SELECT statusGroupMapID FROM [Map].[StatusGroupMap] WHERE StatusID = @statusID AND StatusGroupID = @statusGroupID )
	--PRINT @statusGroupMapID

	/*SELECT   
		tpp.*
		,tpp.OneLoginUserID ReferenceID
		, p.FirstName 
		, p.LastName
		, p.Email 
		,c.[CustomerID] 
		,c.[ReferenceID]
		,p.OrganizationBranchID 
		declare @CompanyID int = 211137
		declare @keyword varchar(30) = 'AL'*/
	SELECT   
		tpp.*
		,tpp.OneLoginUserID ReferenceID
		, p.FirstName 
		, p.LastName
		, p.Email
		, ob.Name CompanyName
		,c.[CustomerID]
		,c.IsActive
		,ct.Name customerTypeName 
		,p.OrganizationBranchID
		,o.OrganizationID

	FROM [Customer].[Customer] c
		INNER JOIN [Map].[ThirdPartyProviderMap] tpp ON c.customerID = tpp.customerID  
		INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
		INNER JOIN [Customer].[OrganizationBranch] ob on p.OrganizationBranchID = ob.OrganizationBranchID
		INNER JOIN [Customer].[Organization] o on ob.OrganizationID = o.OrganizationID
		INNER JOIN [Definition].[PersonTitleType] pt on p.PersonTitleTypeID = pt.PersonTitleTypeID
		INNER JOIN [Definition].[CustomerType] ct on c.CustomerTypeID = ct.CustomerTypeID 
	WHERE	tpp.CompanyID = @CompanyID
	AND p.PersonTitleTypeID			= ( SELECT personTitleTypeID FROM [Definition].[PersonTitleType] WHERE name = 'Employee' )
	AND tpp.ThirdPartyProviderID	= ( SELECT ThirdPartyProviderID FROM [Definition].[ThirdPartyProvider] WHERE name = 'Kronos' )
	AND ( o.Name like '%' + @keyword + '%' or ob.Name like '%' + @keyword + '%' or p.FirstName Like '%' + @keyword + '%'  or p.LastName Like '%' + @keyword + '%' )
	AND	c.StatusGroupMapID	= @statusGroupMapID

	--AND p.PersonTitleTypeID = '27'

END TRY
	BEGIN CATCH
	if(@@TRANCOUNT > 0 )
	BEGIN
		ROLLBACK
		exec dbo.uspRethrowError
	END
	END CATCH  
END




GO
