SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:    <Hamlet Tamazian>
-- Create date: <10/2/2017>
-- Description: <List all Kronos managers for typeahead>
-- =============================================
CREATE PROCEDURE [Customer].[uspTypeaheadKronosManagersSigned] 
  @keyword varchar(50) 
AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.
  SET NOCOUNT ON;
   
  DECLARE @statusID int 			= ( SELECT statusID FROM [definition].[Status] WHERE Name = 'Active' )
  DECLARE @statusGroupID int		= ( SELECT statusGroupID FROM [definition].[StatusGroup] WHERE Name = 'Customer' )
  DECLARE @statusGroupMapID int		= ( SELECT statusGroupMapID FROM [Map].[StatusGroupMap] WHERE StatusID = @statusID AND StatusGroupID = @statusGroupID )

  	SELECT
		  tpm.*
		, p.FirstName 
		, p.LastName
		, p.Email
		, ob.Name CompanyName
		,c.[CustomerID]
		,ct.Name customerTypeName
		--,c.[ReferenceID]
		,tpm.OneLoginUserID ReferenceID
		,p.OrganizationBranchID
		,o.OrganizationID
		,pt.name personTitleType
	
	FROM [Map].[ThirdPartyProviderMap] tpm 
	 
  INNER JOIN [Customer].[Customer] c ON c.CustomerID = tpm.CustomerID
  INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
  INNER JOIN [Definition].[PersonTitleType] pt on p.PersonTitleTypeID = pt.PersonTitleTypeID
  INNER JOIN [Customer].[OrganizationBranch] ob on p.OrganizationBranchID = ob.OrganizationBranchID
  INNER JOIN [Customer].[Organization] o on ob.OrganizationID = o.OrganizationID
  INNER JOIN [Definition].[CustomerType] ct on c.CustomerTypeID = ct.CustomerTypeID 
  WHERE  tpm.ThirdPartyProviderID = ( SELECT ThirdPartyProviderID from [Definition].[ThirdPartyProvider] where name = 'kronos' )
  AND ( o.Name like '%' + @keyword + '%' or ob.Name like '%' + @keyword + '%' or p.FirstName Like '%' + @keyword + '%'  or p.LastName Like '%' + @keyword + '%' )
  AND p.PersonTitleTypeID			= ( SELECT personTitleTypeID FROM [Definition].[PersonTitleType] WHERE name = 'Manager' )
  AND c.StatusGroupMapID = @statusGroupMapID 

  
END




GO
