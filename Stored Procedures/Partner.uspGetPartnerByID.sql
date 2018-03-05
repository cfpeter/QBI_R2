SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <05/30/2017>
-- Description:	< get partner by id>
-- =============================================
CREATE PROCEDURE [Partner].[uspGetPartnerByID] 
	@PartnerID bigint
AS
BEGIN
 
	SET NOCOUNT ON;
  
	SELECT [PartnerID]
		  ,[PartnerTypeID]
		  ,[PersonTitleTypeID]
		  ,[CompanyTypeID]
		  ,[Name]
		  ,[Alias]
		  ,[Address1]
		  ,[Address2]
		  ,[City]
		  ,[StateCode]
		  ,[ZipCode]
		  ,[Email]
		  ,[PhoneNumber]
		  ,[FaxNumber]
		  ,[Gender]
		  ,[OwnershipPercent]
		  ,[IsActive] 
		  ,[CreatedDateTime]
		  ,[CreatedBy]
		  ,[UpdatedDateTime]
		  ,[UpdatedBy]
		  ,[Note]
	  FROM [Partner].[Partner] 

	  WHERE PartnerID = @PartnerID
END


GO
