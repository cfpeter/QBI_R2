SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <05/16/2017>
-- Description:	<Get address by crm referenceID = crmaddressID>
-- =============================================
CREATE PROCEDURE [Common].[uspGetAddressByReferenceID] 
	   @ReferenceID int
	  ,@organizationBranchID int
	  ,@AddressType varchar(50)  
AS
BEGIN
	SET NOCOUNT ON;
	 
	DECLARE @AddressID int 
	

	SET @AddressID = ( SELECT top(1) AddressID from [Customer].[Address] where ReferenceID = @ReferenceID )
	DECLARE @AddressTypeID int = ( SELECT AddressTypeID FROM [Definition].[AddressType]  where name = @AddressType )
	
	IF @AddressID IS NULL 
		BEGIN
			SET @AddressID = (	SELECT top(1) addr.AddressID from [Customer].[Address] addr
					INNER JOIN [Map].[OrganizationBranchAddress] obad on addr.AddressID = obad.AddressID
					WHERE obad.OrganizationBranchID = @organizationBranchID
					AND addr.AddressTypeID = @AddressTypeID
					)
			END

	SELECT * FROM [Customer].[Address] where AddressID = @AddressID
 
END


GO
